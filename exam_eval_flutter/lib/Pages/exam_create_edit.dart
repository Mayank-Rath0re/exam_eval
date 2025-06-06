import 'dart:typed_data';

import 'package:exam_eval_client/exam_eval_client.dart';
import 'package:exam_eval_flutter/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ExamCreateEdit extends StatefulWidget {
  final String title;
  final double duration;
  final int marks;
  final Exam? examData;
  final int mode;
  const ExamCreateEdit(
      {super.key,
      required this.title,
      required this.duration,
      required this.marks,
      this.mode = 1,
      this.examData});

  @override
  State<ExamCreateEdit> createState() => _ExamCreateEditState();
}

class _ExamCreateEditState extends State<ExamCreateEdit> {
  TextEditingController titleController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController marksController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController idealAnswerController = TextEditingController();
  TextEditingController weightageController = TextEditingController();
  List<Question> questions = [];
  bool isLoading = true;
  double weightCalculation = 0;
  bool isGenerating = false;
  int editIndex = -1;

  double calculateWeightage() {
    double result = 0;
    try {
      for (int i = 0; i < questions.length; i++) {
        result += questions[i].weightage;
      }
      return result;
    } catch (err) {
      weightCalculation = -1;
      return -1;
    }
  }

  void generateAnswer(String query) async {
    String resultAnswer = await client.api.generateIdealAnswer(query);
    setState(() {
      idealAnswerController.text = resultAnswer;
      isGenerating = false;
    });
  }

  Widget ocrImageButton() {
    return ElevatedButton(
      onPressed: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          withData: true, // This is important for Web to get file bytes
        );

        if (result != null && result.files.single.bytes != null) {
          setState(() {
            isGenerating = true;
          });

          final platformFile = result.files.single;
          final bytes = platformFile.bytes!;
          final byteData = ByteData.view(bytes.buffer);

          print("Picked file name: ${platformFile.name}");

          try {
            String responseText =
                await client.api.imageOcr(byteData, platformFile.name);
            setState(() {
              idealAnswerController.text += responseText;
              isGenerating = false;
            });
          } catch (e) {
            print("Error during OCR call: $e");
            setState(() {
              isGenerating = false;
            });
          }
        } else {
          print("User canceled the picker or no bytes returned");
        }
      },
      child: Text(
        "Upload from Image",
        style: TextStyle(
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  void submitExam() async {
    if (weightCalculation != widget.marks) {
      // showDialog
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(
                    "Invalid: Total Weightage doesn't add up to total marks"),
              ));
    } else {
      // ignore: unused_local_variable
      if (widget.mode == 1) {
        // ignore: unused_local_variable
        var examCreate = await client.exam.createExam(
            sessionManager.signedInUser!.id!,
            widget.title,
            widget.duration,
            widget.marks,
            questions);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    content: Column(
                  children: [
                    Text("Exam created"),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/dashboard');
                        },
                        child: Text("Back to Dashboard"))
                  ],
                )));
      } else {
        // ignore: unused_local_variable
        var examEdit = await client.exam.editExam(
            sessionManager.signedInUser!.id!,
            widget.examData!.id!,
            widget.title,
            widget.duration,
            widget.marks,
            questions);
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    if (widget.examData != null) {
      setState(() {
        titleController.text = widget.title;
        durationController.text = "${widget.duration}";
        marksController.text = "${widget.marks}";
        questions = widget.examData!.questions;
        weightCalculation = calculateWeightage();
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(
        shrinkWrap: true,
        children: isLoading
            ? [const Center(child: CircularProgressIndicator())]
            : [
                if (widget.mode == 2) ...[
                  Text("Title"),
                  TextField(
                    controller: titleController,
                  ),
                  const SizedBox(height: 10),
                  Text("Duration"),
                  TextField(
                    controller: durationController,
                  ),
                  const SizedBox(height: 10),
                  Text("Marks"),
                  TextField(
                    controller: marksController,
                  ),
                  const SizedBox(height: 10),
                ],
                Row(
                  children: [
                    Text(
                        "Questions Weightage: $weightCalculation/${widget.marks}"),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () {
                          var questionObj =
                              Question(query: "", images: [], weightage: 0);
                          setState(() {
                            editIndex = questions.length;
                            questions.add(questionObj);
                          });
                        },
                        child: Text("Create New Question")),
                  ],
                ),
                const SizedBox(height: 20),
                if (questions.isNotEmpty) ...[
                  for (int i = 0; i < questions.length; i++) ...[
                    if (i == editIndex) ...[
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: const Color(0xFF2D5A27)),
                              borderRadius: BorderRadius.circular(6)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 100,
                                        child: TextField(
                                            decoration: InputDecoration(
                                                hintText: "Weight"),
                                            controller: weightageController)),
                                    const Spacer(),
                                    ElevatedButton(
                                        onPressed: () {
                                          var questionObjEdited = Question(
                                              query: questionController.text,
                                              idealAnswer:
                                                  idealAnswerController.text,
                                              images: [],
                                              weightage: double.parse(
                                                  weightageController.text));
                                          questions[i] = questionObjEdited;
                                          double newWeightage =
                                              calculateWeightage();
                                          questionController.text = "";
                                          idealAnswerController.text = "";
                                          weightageController.text = "";
                                          setState(() {
                                            editIndex = -1;
                                            weightCalculation = newWeightage;
                                          });
                                        },
                                        child: Text(
                                          "Save",
                                          style: TextStyle(
                                              color: Colors.white,
                                              decoration:
                                                  TextDecoration.underline),
                                        ))
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text("Question: ${i + 1}"),
                                const SizedBox(height: 10),
                                TextField(
                                    minLines: 1,
                                    maxLines: 5,
                                    decoration:
                                        InputDecoration(hintText: "Question"),
                                    controller: questionController),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ocrImageButton(),
                                    /*
                              ElevatedButton(
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.image,
                                      withData:
                                          true, // This is important for Web to get file bytes
                                    );
      
                                    if (result != null &&
                                        result.files.single.bytes != null) {
                                      setState(() {
                                        isGenerating = true;
                                      });
      
                                      final platformFile = result.files.single;
                                      final bytes = platformFile.bytes!;
                                      final byteData =
                                          ByteData.view(bytes.buffer);
      
                                      print(
                                          "Picked file name: ${platformFile.name}");
                                      // You can now use the list of image file paths
                                      ocrImage(
                                          byteData, result.files.single.name);
                                    } else {
                                      print("User canceled the picker");
                                    }
                                  },
                                  child: Text(
                                    "Upload from Image",
                                    style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline),
                                  )),*/
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            isGenerating = true;
                                          });
                                          generateAnswer(
                                              questionController.text);
                                        },
                                        child: Text(
                                          "Write with Gemini",
                                          style: TextStyle(
                                              color: Colors.white,
                                              decoration:
                                                  TextDecoration.underline),
                                        ))
                                  ],
                                ),
                                const SizedBox(height: 10),
                                if (isGenerating) ...[
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [CircularProgressIndicator()])
                                ] else ...[
                                  TextField(
                                      minLines: 1,
                                      maxLines: 15,
                                      decoration: InputDecoration(
                                          hintText: "Ideal Answer"),
                                      controller: idealAnswerController)
                                ],
                              ],
                            ),
                          )),
                    ] else ...[
                      Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Weightage: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(width: 10),
                                    Text("${questions[i].weightage}"),
                                    const Spacer(),
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            editIndex = i;
                                            questionController.text =
                                                questions[i].query;
                                            idealAnswerController.text =
                                                questions[i].idealAnswer!;
                                            weightageController.text =
                                                "${questions[i].weightage}";
                                          });
                                        },
                                        child: Text(
                                          "Edit",
                                          style: TextStyle(
                                              color: const Color(0xFF2D5A27),
                                              decoration:
                                                  TextDecoration.underline),
                                        ))
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Question: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(questions[i].query),
                                const SizedBox(height: 10),
                                Text(
                                  "Ideal Answer: ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Text(questions[i].idealAnswer!),
                              ],
                            ),
                          )),
                    ],
                    const SizedBox(height: 10),
                  ]
                ],
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Spacer(),
                    ElevatedButton(
                        onPressed: submitExam,
                        child: Text(
                          "Submit Paper",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                        ))
                  ],
                )
              ],
      ),
    );
  }
}
