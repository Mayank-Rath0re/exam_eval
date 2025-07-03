import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:exam_eval_client/exam_eval_client.dart';
import 'package:exam_eval_flutter/Components/abs_button_primary.dart';
import 'package:exam_eval_flutter/Components/abs_eval_ques.dart';
import 'package:exam_eval_flutter/Components/abs_minimal_box.dart';
import 'package:exam_eval_flutter/Components/abs_text.dart';
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

class _EvaluationPageState extends State<EvaluationPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  // Stepper Variable
  int currentStep = 0;
  // First Page Variables
  bool csvUploaded = false;
  String fileName = "";
  List<List<dynamic>> csvData = [];
  bool isLoading = true; // For loading the resultbatch data
  late List<ResultBatch> resultBatchesDraft;
  late List<ResultBatch> resultBatchesOngoing;
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
      resultBatchesDraft =
          resultBatchInfo.where((t) => t.stage == "Draft").toList();
      resultBatchesOngoing =
          resultBatchInfo.where((t) => t.stage == "Evaluating").toList();
      isLoading = false;
    });
  }

  void fetchResultData(int batchId) async {
    var resultInfo = await client.exam.fetchResultBatchById(batchId);
    setState(() {
      resultData = resultInfo;
    });
  }

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
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
      setState(() {
        fileName = result.files.first.name;
      });
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
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                AbsText(displayString: "Evaluations", fontSize: 24, bold: true),
                const Spacer(),
                if (!csvUploaded) ...[
                  AbsButtonPrimary(
                      onPressed: () {},
                      child:
                          AbsText(displayString: "Choose Exam", fontSize: 14)),
                  const SizedBox(width: 10),
                  AbsButtonPrimary(
                      onPressed: pickCsvFile,
                      child: AbsText(
                          displayString: "Upload from CSV", fontSize: 14))
                ] else ...[
                  AbsText(displayString: "CSV Uploaded", fontSize: 16),
                  const SizedBox(width: 10),
                  AbsButtonPrimary(
                      onPressed: () async {
                        try {
                          // Extract the respective columns from rows
                          List<int> studentIds = csvData
                              .map((row) => int.parse(row[0].toString()))
                              .toList();
                          List<String> studentNames =
                              csvData.map((row) => row[1].toString()).toList();
                          List<int> examIds = csvData
                              .map((row) => int.parse(row[2].toString()))
                              .toList();

                          var resultInfo = await client.exam.createResultBatch(
                            fileName,
                            sessionManager.signedInUser!.id!,
                            studentIds,
                            studentNames,
                            examIds,
                          );
                          fetchResultData(resultInfo);
                          setState(() {
                            activeResultBatchId = resultInfo;
                            csvData = [];
                            currentStep = 1;
                            fileName = "";
                          });
                        } catch (err) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Text(err.toString()),
                                  ));
                        }
                      },
                      child: AbsText(displayString: "Continue", fontSize: 14))
                ]
              ],
            ),
            const SizedBox(height: 20),
            TabBar(
                controller: tabController,
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                tabs: const [
                  AbsText(displayString: "Draft", fontSize: 16),
                  AbsText(displayString: "Ongoing", fontSize: 16)
                ]),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                  controller: tabController,
                  children: isLoading
                      ? [
                          Center(
                              child: AbsText(
                                  displayString: "No Data",
                                  fontSize: 18,
                                  bold: true)),
                          Center(
                              child: AbsText(
                                  displayString: "No Data",
                                  fontSize: 18,
                                  bold: true)),
                        ]
                      : [
                          if (resultBatchesDraft.isEmpty) ...[
                            Center(
                              child: AbsText(
                                  displayString: "No Drafts!",
                                  fontSize: 14,
                                  bold: true),
                            )
                          ] else ...[
                            Wrap(
                              spacing: 10.0,
                              runSpacing: 10.0,
                              alignment: WrapAlignment.start,
                              children: [
                                for (int i = 0;
                                    i < resultBatchesDraft.length;
                                    i++) ...[
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          currentStep = 1;
                                          activeResultBatchId =
                                              resultBatchesDraft[i].id!;
                                          fetchResultData(activeResultBatchId);
                                        });
                                      },
                                      child: AbsMinimalBox(
                                          layer: 1,
                                          child: Column(
                                            children: [
                                              AbsText(
                                                  displayString:
                                                      resultBatchesDraft[i]
                                                          .title,
                                                  fontSize: 14,
                                                  bold: true)
                                            ],
                                          )))
                                ]
                              ],
                            )
                          ],
                          if (resultBatchesOngoing.isEmpty) ...[
                            Center(
                              child: AbsText(
                                  displayString: "No Ongoing Evaluations!",
                                  fontSize: 14,
                                  bold: true),
                            )
                          ] else ...[
                            Wrap(
                              spacing: 10.0,
                              runSpacing: 10.0,
                              alignment: WrapAlignment.start,
                              children: resultBatchesOngoing.map((ongoing) {
                                return AbsMinimalBox(
                                    layer: 1,
                                    child: Column(
                                      children: [
                                        AbsText(
                                            displayString: ongoing.title,
                                            fontSize: 14,
                                            bold: true)
                                      ],
                                    ));
                              }).toList(),
                            )
                          ]
                        ]),
            )
          ],
        ));
  }

  Widget secondPageBuild() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        currentStep = 0;
                      });
                    },
                    icon: Icon(Icons.arrow_back)),
                const Spacer(),
                AbsButtonPrimary(
                    onPressed: () async {
                      bool check = true;
                      for (int i = 0; i < resultData.length; i++) {
                        if (resultData[i].status != "Not graded") {
                          check = false;
                          break;
                        }
                      }
                      if (check) {
                        // Send for evaluation
                        try {
                          // ignore: unused_local_variable
                          var evalReq = await client.exam
                              .evaluateExam(activeResultBatchId);
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Column(
                                      children: [
                                        Text(
                                            "Added for evaluation. This may take some time."),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pushNamed(
                                                  context, '/dashboard');
                                            },
                                            child: Text("Back to Dashboard"))
                                      ],
                                    ),
                                  ));
                        } catch (err) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Text("Some error occured"),
                                  ));
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text("Not all answers are uploaded"),
                                ));
                      }
                    },
                    child:
                        AbsText(displayString: "Evaluate Exam", fontSize: 16))
              ],
            ),
            const SizedBox(height: 10),
            if (resultData.isNotEmpty) ...[
              Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: AbsMinimalBox(
                          layer: 1,
                          child: AbsText(
                              displayString: "Student ID", fontSize: 14))),
                  const SizedBox(width: 5),
                  Expanded(
                      flex: 2,
                      child: AbsMinimalBox(
                          layer: 1,
                          child: AbsText(
                              displayString: "Student Name", fontSize: 14))),
                  const SizedBox(width: 5),
                  Expanded(
                      flex: 1,
                      child: AbsMinimalBox(
                          layer: 1,
                          child:
                              AbsText(displayString: "Exam ID", fontSize: 14))),
                  const SizedBox(width: 5),
                  Expanded(
                      flex: 1,
                      child: AbsMinimalBox(
                          layer: 1,
                          child: AbsText(
                              displayString: "Final Score", fontSize: 14))),
                  const SizedBox(width: 5),
                  Expanded(
                      flex: 1,
                      child: AbsMinimalBox(
                          layer: 1,
                          child: AbsText(
                              displayString: "Required Action", fontSize: 14))),
                ],
              ),
              const SizedBox(height: 5),
              for (int i = 0; i < resultData.length; i++) ...[
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: AbsMinimalBox(
                            layer: 1,
                            child: AbsText(
                                displayString: "${resultData[i].rollNo}",
                                fontSize: 14))),
                    const SizedBox(width: 5),
                    Expanded(
                        flex: 2,
                        child: AbsMinimalBox(
                            layer: 1,
                            child: AbsText(
                                displayString: resultData[i].name,
                                fontSize: 14))),
                    const SizedBox(width: 5),
                    Expanded(
                        flex: 1,
                        child: AbsMinimalBox(
                            layer: 1,
                            child: AbsText(
                                displayString: "${resultData[i].examId}",
                                fontSize: 14))),
                    const SizedBox(width: 5),
                    Expanded(
                        flex: 1,
                        child: AbsMinimalBox(
                            layer: 1,
                            child: AbsText(
                                displayString: resultData[i].status != "graded"
                                    ? resultData[i].status
                                    : "${resultData[i].finalScore}",
                                fontSize: 14))),
                    const SizedBox(width: 5),
                    Expanded(
                        flex: 1,
                        child: AbsButtonPrimary(
                            onPressed: () {
                              // Route to evaluate scaffold
                              prepareData(i);
                            },
                            child: AbsText(
                                displayString: "Upload", fontSize: 13))),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ] else ...[
              const AbsText(
                  displayString:
                      "No CSV data to display or all cells are empty.",
                  fontSize: 18)
            ]
          ],
        ));
  }

  Widget thirdPageBuild() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(height: 5),
                AbsText(
                    displayString: "Upload Answer", fontSize: 24, bold: true),
                const SizedBox(height: 10),
                AbsText(
                    displayString: "Name: ${resultData[evaluatingIndex].name}",
                    fontSize: 16,
                    bold: true),
                const SizedBox(height: 5),
                AbsText(
                    displayString:
                        "Exam ID: ${resultData[evaluatingIndex].examId}",
                    fontSize: 16,
                    bold: true),
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
              ],
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (currentStep == 0) {
      return firstPageBuild();
    } else if (currentStep == 1) {
      return secondPageBuild();
    } else if (currentStep == 2) {
      return thirdPageBuild();
    }
    return const Placeholder();
  }
}

class ResponsiveEvaluateExam extends StatelessWidget {
  const ResponsiveEvaluateExam({super.key});

  @override
  Widget build(BuildContext context) {
    //return const EvaluateExamPage();
    return const EvaluationPage();
  }
}
