import 'dart:typed_data';
import 'package:exam_eval_client/exam_eval_client.dart';
import 'package:exam_eval_flutter/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ExamDefinePage extends StatefulWidget {
  const ExamDefinePage({super.key});

  @override
  State<ExamDefinePage> createState() => _ExamDefinePageState();
}

class _ExamDefinePageState extends State<ExamDefinePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _marksController = TextEditingController();
  TextEditingController questionController = TextEditingController();
  TextEditingController idealAnswerController = TextEditingController();
  TextEditingController weightageController = TextEditingController();
  List<Question> questions = [];
  double weightCalculation = 0;
  bool isGenerating = false;
  int currentPage = 0;
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
    if (weightCalculation != int.parse(_marksController.text)) {
      // showDialog
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: Text(
                    "Invalid: Total Weightage doesn't add up to total marks"),
              ));
    } else {
      // ignore: unused_local_variable
      var examCreate = await client.exam.createExam(
          sessionManager.signedInUser!.id!,
          _titleController.text,
          double.parse(_durationController.text),
          int.parse(_marksController.text),
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
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _durationController.dispose();
    _marksController.dispose();
  }

  Widget _buildFirstPage() {
    return SingleChildScrollView(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Exam Icon with Animation
                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 2 * math.pi),
                        duration: const Duration(seconds: 3),
                        builder: (context, value, child) {
                          return Transform.rotate(
                            angle: math.sin(value) * 0.05,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.book,
                                size: 64,
                                color: const Color(0xFF2D5A27),
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Exam Title',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: 'Enter exam title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Duration (Minutes)',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _durationController,
                        decoration: InputDecoration(
                          hintText: 'Enter exam duration',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Total Marks',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _marksController,
                        decoration: InputDecoration(
                          hintText: 'Enter total marks',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              currentPage = 1;
                            });
                          },
                          //onPressed: _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2D5A27),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Next →',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondPage() {
    return Column(
      children: [
        Row(
          children: [
            Text(
                "Questions Weightage: $weightCalculation/${_marksController.text}"),
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
                      border:
                          Border.all(width: 1, color: const Color(0xFF2D5A27)),
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
                                    decoration:
                                        InputDecoration(hintText: "Weight"),
                                    controller: weightageController)),
                            const Spacer(),
                            ElevatedButton(
                                onPressed: () {
                                  var questionObjEdited = Question(
                                      query: questionController.text,
                                      idealAnswer: idealAnswerController.text,
                                      images: [],
                                      weightage: double.parse(
                                          weightageController.text));
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
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                ))
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text("Question: ${i + 1}"),
                        const SizedBox(height: 10),
                        TextField(
                            minLines: 1,
                            maxLines: 5,
                            decoration: InputDecoration(hintText: "Question"),
                            controller: questionController),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                  generateAnswer(questionController.text);
                                },
                                child: Text(
                                  "Write with Gemini",
                                  style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                ))
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (isGenerating) ...[
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [CircularProgressIndicator()])
                        ] else ...[
                          TextField(
                              minLines: 1,
                              maxLines: 15,
                              decoration:
                                  InputDecoration(hintText: "Ideal Answer"),
                              controller: idealAnswerController)
                        ],
                      ],
                    ),
                  )),
            ] else ...[
              Container(
                  decoration: BoxDecoration(border: Border.all(width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Weightage: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                                      decoration: TextDecoration.underline),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            children: [
              if (currentPage == 0) ...[
                _buildFirstPage()
              ] else ...[
                Text("Structure Question Paper"),
                const SizedBox(height: 25),
                _buildSecondPage()
              ]
            ],
          ),
        ));
  }
}
