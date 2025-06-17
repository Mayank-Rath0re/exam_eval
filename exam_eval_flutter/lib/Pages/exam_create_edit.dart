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
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(54, 87, 78, 1),
        foregroundColor: Colors.white,
      ),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(54, 87, 78, 1),
                          foregroundColor: Colors.white,
                        ),
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
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          shrinkWrap: true,
          children: isLoading
              ? [const Center(child: CircularProgressIndicator())]
              : [
                  if (widget.mode == 2) ...[
                    Text(
                      "Title",
                      style: TextStyle(
                        color: Color.fromRGBO(54, 87, 78, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(54, 87, 78, 1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Duration",
                      style: TextStyle(
                        color: Color.fromRGBO(54, 87, 78, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: durationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(54, 87, 78, 1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Marks",
                      style: TextStyle(
                        color: Color.fromRGBO(54, 87, 78, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      controller: marksController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Color.fromRGBO(54, 87, 78, 1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                  Container(
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
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          "Questions Weightage: $weightCalculation/${widget.marks}",
                          style: const TextStyle(
                            color: Color.fromRGBO(54, 87, 78, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(54, 87, 78, 1),
                            foregroundColor: Colors.white,
                          ),
                          child: Text("Create New Question"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (questions.isNotEmpty) ...[
                    for (int i = 0; i < questions.length; i++) ...[
                      if (i == editIndex) ...[
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(227, 221, 211, 1),
                            border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(54, 87, 78, 1),
                            ),
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
                                          hintText: "Weight",
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide: const BorderSide(
                                              color: Color.fromRGBO(54, 87, 78, 1),
                                            ),
                                          ),
                                        ),
                                        controller: weightageController,
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                      onPressed: () {
                                        var questionObjEdited = Question(
                                          query: questionController.text,
                                          idealAnswer: idealAnswerController.text,
                                          images: [],
                                          weightage: double.parse(
                                            weightageController.text,
                                          ),
                                        );
                                        questions[i] = questionObjEdited;
                                        double newWeightage = calculateWeightage();
                                        questionController.text = "";
                                        idealAnswerController.text = "";
                                        weightageController.text = "";
                                        setState(() {
                                          editIndex = -1;
                                          weightCalculation = newWeightage;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(54, 87, 78, 1),
                                        foregroundColor: Colors.white,
                                      ),
                                      child: Text(
                                        "Save",
                                        style: TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Question: ${i + 1}",
                                  style: const TextStyle(
                                    color: Color.fromRGBO(54, 87, 78, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  minLines: 1,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    hintText: "Question",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color.fromRGBO(54, 87, 78, 1),
                                      ),
                                    ),
                                  ),
                                  controller: questionController,
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ocrImageButton(),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          isGenerating = true;
                                        });
                                        generateAnswer(questionController.text);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(54, 87, 78, 1),
                                        foregroundColor: Colors.white,
                                      ),
                                      child: Text(
                                        "Write with Gemini",
                                        style: TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                if (isGenerating) ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [CircularProgressIndicator()],
                                  )
                                ] else ...[
                                  TextField(
                                    minLines: 1,
                                    maxLines: 15,
                                    decoration: InputDecoration(
                                      hintText: "Ideal Answer",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(54, 87, 78, 1),
                                        ),
                                      ),
                                    ),
                                    controller: idealAnswerController,
                                  )
                                ],
                              ],
                            ),
                          ),
                        ),
                      ] else ...[
                        Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(227, 221, 211, 1),
                            border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(54, 87, 78, 1),
                            ),
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
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(54, 87, 78, 1),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "${questions[i].weightage}",
                                      style: const TextStyle(
                                        color: Color.fromRGBO(54, 87, 78, 1),
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          editIndex = i;
                                          questionController.text = questions[i].query;
                                          idealAnswerController.text = questions[i].idealAnswer!;
                                          weightageController.text = "${questions[i].weightage}";
                                        });
                                      },
                                      child: Text(
                                        "Edit",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(54, 87, 78, 1),
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Question: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(54, 87, 78, 1),
                                  ),
                                ),
                                Text(
                                  questions[i].query,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(54, 87, 78, 1),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "Ideal Answer: ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(54, 87, 78, 1),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  questions[i].idealAnswer!,
                                  style: const TextStyle(
                                    color: Color.fromRGBO(54, 87, 78, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(54, 87, 78, 1),
                          foregroundColor: Colors.white,
                        ),
                        child: Text(
                          "Submit Paper",
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  )
                ],
        ),
      ),
    );
  }
}
