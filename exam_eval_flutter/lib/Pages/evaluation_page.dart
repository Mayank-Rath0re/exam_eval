import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:exam_eval_client/exam_eval_client.dart';
import 'package:exam_eval_flutter/Components/abs_eval_ques.dart';
import 'package:exam_eval_flutter/Pages/file_reader.dart';
import 'package:exam_eval_flutter/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EvaluationPage extends StatefulWidget {
  const EvaluationPage({super.key});

  @override
  State<EvaluationPage> createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage> {
  // Stepper Variable
  int currentStep = 0;
  // First Page Variables
  bool csvUploaded = false;
  List<List<dynamic>> csvData = [];
  bool isLoading = true; // For loading the resultbatch data
  late List<ResultBatch> resultBatches;
  late int activeResultBatchId;
  // Second page variables
  late List<Result> resultData;
  late Answer uploadedAnswers;
  int evaluatingIndex = -1;
  late Exam examData;
  bool isLoadingExam = true;
  // Third Page Variables

  void getResultBatches() async {
    var resultBatchInfo =
        await client.exam.fetchResultBatch(sessionManager.signedInUser!.id!);
    setState(() {
      resultBatches = resultBatchInfo;
      isLoading = false;
    });
  }

  @override
  void initState() {
    getResultBatches();
    super.initState();
  }

  void initializeUploadedArray(int len) {
    for (int i = 0; i < len; i++) {
      setState(() {
        uploadedAnswers.submittedAnswer.add("");
        uploadedAnswers.evaluatedScore.add(-1);
      });
    }
  }

  void startEvaluation() async {
    bool dataReady = true;
    for (int i = 0; i < resultData.length; i++) {
      if (resultData[i].status == "Not uploaded") {
        dataReady = false;
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text("Answers not uploaded for all data"),
                ));
      }
    }
    if (dataReady) {
      try {
        client.exam.evaluateExam(activeResultBatchId);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: SizedBox(
                    child: Column(
                      children: [
                        Text("Evaluating Results. This will take some time."),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/dashboard');
                            },
                            child: Text("Go Back"))
                      ],
                    ),
                  ),
                ));
      } catch (err) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  content: Text(err.toString()),
                ));
      }
    }
  }

  void prepareData(int evalIndex) async {
    try {
      var examInfo = await client.exam.fetchExam(resultData[evalIndex].examId);
      var answerObj =
          await client.exam.fetchAnswer(resultData[evalIndex].answers);
      setState(() {
        uploadedAnswers = answerObj!;
      });
      if (answerObj!.submittedAnswer.isEmpty) {
        initializeUploadedArray(examInfo.questions.length);
      }
      setState(() {
        examData = examInfo;
        isLoadingExam = false;
        evaluatingIndex = evalIndex;
        currentStep = 2;
      });
    } catch (err) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(err.toString()),
              ));
    }
  }

  Future<void> pickCsvFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true, // ensure bytes are available for web
    );
    if (result != null) {
      String content = '';
      if (kIsWeb) {
        // On web, use bytes
        final bytes = result.files.single.bytes;
        if (bytes != null) {
          content = utf8.decode(bytes);
        }
      } else {
        // On desktop/mobile, use file path
        final path = result.files.single.path;
        if (path != null) {
          content = await readFileAsString(path);
        }
      }
      if (content.isNotEmpty) {
        final rows = const CsvToListConverter().convert(content);
        setState(() {
          csvUploaded = true;
          csvData = rows;
        });
        print('CSV DATA:');
        print(rows);
      }
    }
  }

  Widget firstPageBuild() {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Expanded(
        flex: 3,
        child: Column(
          children: [
            Text("Your Results"),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: isLoading
                  ? [CircularProgressIndicator()]
                  : resultBatches.isEmpty
                      ? [Text("No Result Batches Created")]
                      : List.generate(resultBatches.length, (index) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              children: [
                                Text("${resultBatches[index].uploadedAt}"),
                                const SizedBox(height: 10),
                                if (resultBatches[index].isDraft) ...[
                                  Text(
                                    "Draft",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                                const SizedBox(height: 10),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        currentStep = 1;
                                        resultData =
                                            resultBatches[index].contents;
                                        activeResultBatchId = index;
                                      });
                                    },
                                    child: Text("Continue"))
                              ],
                            ),
                          );
                        }),
            )
          ],
        ),
      ),
      Expanded(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Create New Evaluation"),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    // Need to be built
                  },
                  child: Text("Choose Exam")),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: pickCsvFile, child: Text("Upload from CSV")),
              const SizedBox(height: 10),
              if (csvUploaded) ...[
                Row(
                  children: [
                    Text("CSV Uploaded Successfully"),
                    ElevatedButton(
                        onPressed: () async {
                          try {
                            // Extract the respective columns from rows
                            List<int> studentIds = csvData
                                .map((row) => int.parse(row[0].toString()))
                                .toList();
                            List<String> studentNames = csvData
                                .map((row) => row[1].toString())
                                .toList();
                            List<int> examIds = csvData
                                .map((row) => int.parse(row[2].toString()))
                                .toList();

                            var resultInfo =
                                await client.exam.createResultBatch(
                              sessionManager.signedInUser!.id!,
                              studentIds,
                              studentNames,
                              examIds,
                            );
                            setState(() {
                              activeResultBatchId = resultInfo[0];
                              resultData = resultInfo[1];
                              csvData = [];
                              currentStep = 1;
                            });
                          } catch (err) {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      content: Text(err.toString()),
                                    ));
                          }
                        },
                        child: Text("Continue"))
                  ],
                )
              ],
            ],
          ),
        ),
      )
    ]);
  }

  Widget secondPageBuild() {
    return ListView(
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              currentStep = 0;
            });
          },
        ),
        if (resultData.isNotEmpty) ...[
          const SizedBox(height: 5),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(onPressed: () {}, child: Text("Evaluate"))
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Table(
              border: TableBorder.all(), // Optional: adds borders around cells
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[300]),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Student ID',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Student Name'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Exam ID'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Final Score'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Required Action'),
                    ),
                  ],
                ),
                for (int i = 0; i < resultData.length; i++) ...[
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${resultData[i].rollNo}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(resultData[i].name),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${resultData[i].examId}"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: resultData[i].status != "Evaluated"
                            ? Text(resultData[i].status)
                            : Text("${resultData[i].finalScore}"),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              onPressed: () {
                                // Route to evaluate scaffold
                                prepareData(i);
                              },
                              child: Text("Upload"))),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ] else ...[
          const Text('No CSV data to display or all cells are empty.'),
        ],
      ],
    );
  }

  Widget thirdPageBuild() {
    return ListView(children: [
      Text(resultData[evaluatingIndex].name),
      Text("Exam ID: ${resultData[evaluatingIndex].examId}"),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Center(child: Text("Save Changes?")),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  currentStep = 1;
                                });
                              },
                              child: Text("Discard")),
                          ElevatedButton(
                              onPressed: () async {
                                // Save Draft
                                await client.exam.saveAnswers(
                                    resultData[evaluatingIndex].id!,
                                    uploadedAnswers);
                                Navigator.pop(context);
                                setState(() {
                                  currentStep = 1;
                                });
                              },
                              child: Text("Save"))
                        ],
                      ));
            },
            icon: Icon(Icons.arrow_back)),
        const Spacer(),
        ElevatedButton(
            onPressed: () async {
              bool check = true;
              for (int i = 0; i < uploadedAnswers.submittedAnswer.length; i++) {
                if (uploadedAnswers.submittedAnswer[i].isEmpty) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Text("Not all answers are uploaded"),
                          ));
                  check = false;
                  break;
                }
              }
              if (check) {
                // Send for evaluation
                try {
                  await client.exam.saveAnswers(
                      resultData[evaluatingIndex].id!, uploadedAnswers);
                  // ignore: unused_local_variable
                  var evalReq =
                      await client.exam.evaluateExam(activeResultBatchId);
                  setState(() {
                    currentStep = 1;
                    uploadedAnswers =
                        Answer(submittedAnswer: [], evaluatedScore: []);
                  });
                } catch (err) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            content: Text("Some error occured"),
                          ));
                }
              }
            },
            child: Text("Evaluate Exam"))
      ]),
      const SizedBox(height: 20),
      for (int i = 0; i < examData.questions.length; i++) ...[
        AbsEvalQues(
            index: i,
            question: examData.questions[i],
            uploadedAnswer: uploadedAnswers.submittedAnswer[i],
            evaluatedScore: uploadedAnswers.evaluatedScore[i],
            onGenerated: (val) {
              setState(() {
                uploadedAnswers.submittedAnswer[i] = val;
              });
            }),
        const SizedBox(height: 5),
      ],
    ]);
  }

  @override
  Widget build(BuildContext context) {
    if (currentStep == 0) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: firstPageBuild(),
      );
    } else if (currentStep == 1) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: secondPageBuild(),
      );
    } else if (currentStep == 2) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: thirdPageBuild(),
      );
    }
    return const Placeholder();
  }
}
