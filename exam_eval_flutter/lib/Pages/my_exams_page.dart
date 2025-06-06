import 'package:exam_eval_client/exam_eval_client.dart';
import 'package:exam_eval_flutter/Pages/exam_create_edit.dart';
import 'package:exam_eval_flutter/main.dart';
import 'package:flutter/material.dart';

class MyExamsPage extends StatefulWidget {
  const MyExamsPage({super.key});

  @override
  State<MyExamsPage> createState() => _MyExamsPageState();
}

class _MyExamsPageState extends State<MyExamsPage> {
  late List<Exam> examData;
  bool isLoading = true;

  void fetchData() async {
    var exams =
        await client.exam.fetchUserExams(sessionManager.signedInUser!.id!);
    setState(() {
      examData = exams;
      isLoading = false;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Scaffold editPage(Exam examData) {
    return Scaffold(
      body: ExamCreateEdit(
        title: examData.title,
        duration: examData.duration,
        marks: examData.totalMarks,
        examData: examData,
        mode: 2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("My Exams", style: TextStyle(fontSize: 30)),
                const SizedBox(height: 30),
                if (examData.isEmpty) ...[
                  Center(child: Text("No Exams Created")),
                ],
                for (int i = 0; i < examData.length; i++) ...[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${examData[i].id!}."),
                          const SizedBox(width: 10),
                          Text(
                            examData[i].title,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "${examData[i].duration} minutes",
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "${examData[i].totalMarks} marks",
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "${examData[i].questions.length} questions",
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                editPage(examData[i])));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit_document),
                                      const SizedBox(width: 3),
                                      Text(
                                        "Edit",
                                      )
                                    ],
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              content: Text("Are you sure?"),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Cancel")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      client.exam.deleteExam(
                                                          examData[i].id!);
                                                      setState(() {
                                                        examData.removeAt(i);
                                                      });
                                                    },
                                                    child: Text("Yes"))
                                              ],
                                            ));
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStatePropertyAll(Colors.red)),
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete_outline),
                                      const SizedBox(width: 3),
                                      Text("Delete")
                                    ],
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10)
                ]
              ],
            ),
          );
  }
}
