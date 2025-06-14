import 'dart:typed_data';

import 'package:exam_eval_client/exam_eval_client.dart';
import 'package:exam_eval_flutter/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class AbsEvalQues extends StatefulWidget {
  final int index;
  final Question question;
  final Answer answerObj;
  final Function(String)? onGenerated;
  const AbsEvalQues({super.key,required this.index, required this.question, required this.answerObj, required this.onGenerated});

  @override
  State<AbsEvalQues> createState() => _AbsEvalQuesState();
}

class _AbsEvalQuesState extends State<AbsEvalQues> {
  bool isGenerating = false;

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
            widget.onGenerated!(responseText);
            setState(() {
              widget.answerObj.submittedAnswer = responseText;
              isGenerating = false;
            });
          } catch (e) {
            showDialog(context: context, builder: (context) => AlertDialog(content: Text("$e"),));
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
        "Upload",
        style: TextStyle(
          color: Colors.white,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(width:1), borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text("Question: ${widget.index + 1}"),
                            const Spacer(),
                            Text("Final Score: ${widget.answerObj.evaluatedScore==-1 ? "Not evaluated" : widget.answerObj.evaluatedScore}")
                          ],),
                          const SizedBox(height: 10),
                          Text("Question: ${widget.question.query}"),
                          const SizedBox(height: 10),
                          Text("Ideal Answer: ${widget.question.idealAnswer}"),
                          const SizedBox(height: 10),
                          if(isGenerating)...[
                            const Center(child: CircularProgressIndicator())
                          ] else...[
                            if(widget.answerObj.submittedAnswer.isEmpty)...[
                              ocrImageButton()
                            ]else...[
                              Text(widget.answerObj.submittedAnswer)
                            ]
                          ]
                        ],
                      ),
                    )),
                );
  }
}