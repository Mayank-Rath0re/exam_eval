import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:exam_eval_client/exam_eval_client.dart';
import 'package:exam_eval_flutter/Components/abs_eval_ques.dart';
import 'package:exam_eval_flutter/Pages/evaluation_page.dart';
import 'package:exam_eval_flutter/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'file_reader.dart';

class EvaluateExamPage extends StatefulWidget {
  const EvaluateExamPage({super.key});

  @override
  State<EvaluateExamPage> createState() => _EvaluateExamPageState();
}

class _EvaluateExamPageState extends State<EvaluateExamPage> {
  bool csvUploaded = false;
  List<List<dynamic>> csvData = [];
  late List<Result> resultData;
  late List<ResultBatch> resultBatches;
  bool isLoading = true;
  int evaluatingIndex = -1;
  late Exam examData;
  bool isLoadingExam = true;
  Answer? uploadedAnswers;
  bool evaluatingExam = false;
  List<int> generatingIndex = [];

  void getResultBatches() async {
    var resultBatchInfo =
        await client.exam.fetchResultBatch(sessionManager.signedInUser!.id!);
    setState(() {
      resultBatches = resultBatchInfo;
      isLoading = false;
    });
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

  int currentStep = 0;

  void goToNextStep() {
    setState(() {
      currentStep++;
      print(currentStep);
    });
  }

  void prepareData(int evalIndex) async {
    try {
      var examInfo = await client.exam.fetchExam(resultData[evalIndex].examId);
      var answerObj =
          await client.exam.fetchAnswer(resultData[evalIndex].answers);
      if (answerObj == null) {
        initializeUploadedArray(examInfo.questions.length);
      } else {
        setState(() {
          uploadedAnswers = answerObj;
        });
      }
      setState(() {
        examData = examInfo;
        isLoadingExam = false;
        evaluatingIndex = evalIndex;
      });
      goToNextStep();
    } catch (err) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(err.toString()),
              ));
    }
  }

  void initializeUploadedArray(int len) {
    for (int i = 0; i < len; i++) {
      setState(() {
        uploadedAnswers!.submittedAnswer.add("");
        uploadedAnswers!.evaluatedScore.add(-1);
      });
    }
  }

  void answerBuild(int answerId) async {}

  @override
  void initState() {
    getResultBatches();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: ListView(
          children: [
            if (currentStep == 0) ...[
              Container(
                width: 450,
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6DD5FA), Color(0xFF2980F2)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: const Color(0xFF624B8A),
                          width: 6,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      child: const Text(
                        'Choose an Exam',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Divider(
                      color: Colors.white,
                      thickness: 3,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: pickCsvFile,
                      icon: const Icon(Icons.upload_file,
                          color: Color(0xFF624B8A)),
                      label: const Text(
                        'Upload CSV',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF624B8A),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF624B8A),
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                    if (csvUploaded) ...[
                      const SizedBox(height: 16),
                      const Text(
                        'CSV uploaded',
                        style: TextStyle(
                          color: Color(0xFF624B8A),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: 180,
                        height: 48,
                        child: ElevatedButton(
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
                                resultData = resultInfo;
                                csvData = [];
                              });

                              goToNextStep();
                            } catch (err) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        content: Text(err.toString()),
                                      ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF624B8A),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    Text("Your Result Drafts"),
                    const SizedBox(height: 10),
                    if (isLoading) ...[
                      CircularProgressIndicator()
                    ] else ...[
                      for (int i = 0; i < resultBatches.length; i++) ...[
                        Container(
                          child: Column(
                            children: [
                              Text(
                                  "${resultBatches[i].uploadedAt} - ${resultBatches[i].isDraft ? "Draft" : "Completed"}"),
                              const SizedBox(height: 5),
                              ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      resultData = resultBatches[i].contents;
                                    });
                                    goToNextStep();
                                  },
                                  child: Text("Continue"))
                            ],
                          ),
                        )
                      ]
                    ]
                  ],
                ),
              ),
            ] else if (currentStep == 1) ...[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    currentStep--;
                  });
                },
              ),
              // Display CSV as a table
              if (resultData.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Table(
                    border: TableBorder
                        .all(), // Optional: adds borders around cells
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
                                    child: Text("Upload $i"))),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ] else ...[
                const Text('No CSV data to display or all cells are empty.'),
              ],
            ] else if (currentStep == 2) ...[
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
                                          currentStep--;
                                        });
                                      },
                                      child: Text("Discard")),
                                  ElevatedButton(
                                      onPressed: () async {
                                        // Save Draft
                                        await client.exam.saveAnswers(
                                            resultData[evaluatingIndex].id!,
                                            uploadedAnswers!);
                                        Navigator.pop(context);
                                        setState(() {
                                          currentStep--;
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
                      for (int i = 0;
                          i < uploadedAnswers!.submittedAnswer.length;
                          i++) {
                        if (uploadedAnswers!.submittedAnswer[i].isEmpty) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content:
                                        Text("Not all answers are uploaded"),
                                  ));
                          check = false;
                          break;
                        }
                      }
                      if (check) {
                        // Send for evaluation
                        try {
                          await client.exam.saveAnswers(
                              resultData[evaluatingIndex].id!,
                              uploadedAnswers!);
                          // ignore: unused_local_variable
                          var evalReq = await client.exam.evaluateExam(
                              resultData[evaluatingIndex].examId,
                              resultData[evaluatingIndex].rollNo,
                              resultData[evaluatingIndex].answers);
                          setState(() {
                            currentStep--;
                            uploadedAnswers = null;
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
                    uploadedAnswer: uploadedAnswers!.submittedAnswer[i],
                    evaluatedScore: uploadedAnswers!.evaluatedScore[i],
                    onGenerated: (val) {
                      setState(() {
                        uploadedAnswers!.submittedAnswer[i] = val;
                      });
                    }),
                const SizedBox(height: 5),
              ],
            ],
            const SizedBox(height: 32),
            // Progress indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 32,
                  height: 16,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: currentStep == 0
                              ? Colors.black54
                              : Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                          color: currentStep == 1
                              ? Colors.black54
                              : Colors.grey[300],
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Responsive version that can be integrated with the responsive layout
class ResponsiveEvaluateExam extends StatelessWidget {
  const ResponsiveEvaluateExam({super.key});

  @override
  Widget build(BuildContext context) {
    //return const EvaluateExamPage();
    return const EvaluationPage();
  }
}
