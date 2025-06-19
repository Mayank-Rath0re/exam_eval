import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:exam_eval_client/exam_eval_client.dart';
import 'package:exam_eval_flutter/Components/abs_eval_ques.dart';
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
  int evaluatingIndex = -1;
  late Exam examData;
  bool isLoadingExam = true;
  Answer? uploadedAnswers;
  bool evaluatingExam = false;
  List<int> generatingIndex = [];

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

  void fetchExamData(int examId) async {
    var examInfo = await client.exam.fetchExam(examId);
    setState(() {
      examData = examInfo;
      isLoadingExam = false;
    });
  }

  void initializeUploadedArray(int len) {
    for (int i = 0; i < len; i++) {
      setState(() {
        uploadedAnswers!.submittedAnswer.add("");
        uploadedAnswers!.evaluatedScore.add(-1);
      });
    }
  }

  void answerBuild(int answerId) async {
    var answerObj = await client.exam.fetchAnswer(answerId);
    if (answerObj!.submittedAnswer.isEmpty) {
      initializeUploadedArray(examData.questions.length);
    } else {
      setState(() {
        uploadedAnswers = answerObj;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0.8, 0.8),
          radius: 2.3,
          colors: [
            Color.fromRGBO(247, 245, 243, 1),
            Color.fromRGBO(227, 221, 211, 1),
            Color.fromRGBO(212, 199, 130, 1),
            Color.fromRGBO(54, 87, 78, 1),
          ],
          stops: [0.0, 0.1, 0.52, 0.81],
        ),
      ),
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
                  color: const Color.fromRGBO(227, 221, 211, 1),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      spreadRadius: 4,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: const Color.fromRGBO(54, 87, 78, 1),
                          width: 3,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      child: const Text(
                        'Choose an Exam',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color.fromRGBO(54, 87, 78, 1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Divider(
                      color: Color.fromRGBO(54, 87, 78, 1),
                      thickness: 2,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: pickCsvFile,
                      icon: const Icon(Icons.upload_file,
                          color: Color.fromRGBO(54, 87, 78, 1)),
                      label: const Text(
                        'Upload CSV',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(54, 87, 78, 1),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color.fromRGBO(54, 87, 78, 1),
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
                          color: Color.fromRGBO(54, 87, 78, 1),
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                    if (csvUploaded) ...[
                      const SizedBox(height: 32),
                      SizedBox(
                        width: 180,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () async {
                            var resultInfo =
                                await client.exam.createResultBatch(
                                    sessionManager.signedInUser!.id!,
                                    csvData[0].map((studentId) {
                                      return int.parse(studentId);
                                    }).toList(),
                                    csvData[0].map((studentName) {
                                      return "$studentName";
                                    }).toList(),
                                    csvData[3].map((examId) {
                                      return int.parse(examId);
                                    }).toList());
                            setState(() {
                              resultData = resultInfo;
                              csvData = [];
                            });
                            goToNextStep;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(54, 87, 78, 1),
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
                  ],
                ),
              ),
            ] else if (currentStep == 1) ...[
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    currentStep--;
                  });
                },
              ),
              // Display CSV as a table
              if (csvData.isNotEmpty &&
                  csvData.any((row) => row
                      .any((cell) => cell.toString().trim().isNotEmpty))) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(227, 221, 211, 1),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          spreadRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Table(
                      border: TableBorder.all(
                        color: const Color.fromRGBO(54, 87, 78, 1),
                        width: 1.5,
                      ),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(3),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(212, 199, 130, 0.2),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Student ID',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(54, 87, 78, 1),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Student Name',
                                  style: TextStyle(
                                    color: Color.fromRGBO(54, 87, 78, 1),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Exam ID',
                                  style: TextStyle(
                                    color: Color.fromRGBO(54, 87, 78, 1),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Final Score',
                                  style: TextStyle(
                                    color: Color.fromRGBO(54, 87, 78, 1),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Required Action',
                                  style: TextStyle(
                                    color: Color.fromRGBO(54, 87, 78, 1),
                                  )),
                            ),
                          ],
                        ),
                        for (int i = 0; i < resultData.length; i++) ...[
                          TableRow(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${resultData[i].rollNo}",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(54, 87, 78, 1),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(resultData[i].name,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(54, 87, 78, 1),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("${resultData[i].examId}",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(54, 87, 78, 1),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: resultData[i].status != "Evaluated"
                                    ? Text(resultData[i].status,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(54, 87, 78, 1),
                                        ))
                                    : Text("${resultData[i].finalScore}",
                                        style: const TextStyle(
                                          color: Color.fromRGBO(54, 87, 78, 1),
                                        )),
                              ),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        // Route to evaluate scaffold
                                        fetchExamData(resultData[i].examId);
                                        initializeUploadedArray(
                                            examData.questions.length);
                                        setState(() {
                                          evaluatingIndex = i;
                                          goToNextStep();
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color.fromRGBO(54, 87, 78, 1),
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text("Upload"))),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ] else ...[
                const Text('No CSV data to display or all cells are empty.'),
              ],
            ] else if (currentStep == 2) ...[
              Text(resultData[evaluatingIndex].name,
                  style: const TextStyle(
                    color: Color.fromRGBO(54, 87, 78, 1),
                    fontWeight: FontWeight.bold,
                  )),
              Text("Exam ID: ",
                  style: const TextStyle(
                    color: Color.fromRGBO(54, 87, 78, 1),
                    fontWeight: FontWeight.bold,
                  )),
              Text("${resultData[evaluatingIndex].examId}",
                  style: const TextStyle(
                    color: Color.fromRGBO(54, 87, 78, 1),
                  )),
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
                                      child: const Text("Discard")),
                                  ElevatedButton(
                                      onPressed: () async {
                                        // Save Draft
                                        await client.exam
                                            .saveAnswers(uploadedAnswers!);
                                        Navigator.pop(context);
                                        setState(() {
                                          currentStep--;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color.fromRGBO(54, 87, 78, 1),
                                        foregroundColor: Colors.white,
                                      ),
                                      child: const Text("Save"))
                                ],
                              ));
                    },
                    icon: const Icon(Icons.arrow_back)),
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
                                    content: const Text(
                                        "Not all answers are uploaded"),
                                  ));
                          check = false;
                          break;
                        }
                      }
                      if (check) {
                        // Send for evaluation
                        try {
                          await client.exam.saveAnswers(uploadedAnswers!);
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
                                    content: const Text("Some error occured"),
                                  ));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(54, 87, 78, 1),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Evaluate Exam"))
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
    return const EvaluateExamPage();
  }
}
