import 'dart:typed_data';

import 'package:exam_eval_client/exam_eval_client.dart';
import 'package:exam_eval_flutter/Components/abs_button_primary.dart';
import 'package:exam_eval_flutter/Components/abs_minimal_box.dart';
import 'package:exam_eval_flutter/Components/abs_text.dart';
import 'package:exam_eval_flutter/main.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AbsEvalQues extends StatefulWidget {
  final int index;
  final Question question;
  String? uploadedAnswer;
  final double evaluatedScore;
  final Function(String)? onGenerated;
  AbsEvalQues(
      {super.key,
      required this.index,
      required this.question,
      required this.uploadedAnswer,
      required this.evaluatedScore,
      required this.onGenerated});

  @override
  State<AbsEvalQues> createState() => _AbsEvalQuesState();
}

class _AbsEvalQuesState extends State<AbsEvalQues> {
  bool isGenerating = false;

  Widget ocrImageButton() {
    return AbsButtonPrimary(
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
                widget.uploadedAnswer = responseText;
                isGenerating = false;
              });
            } catch (e) {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Text("$e"),
                      ));
              print("Error during OCR call: $e");
              setState(() {
                isGenerating = false;
              });
            }
          } else {
            print("User canceled the picker or no bytes returned");
          }
        },
        child: AbsText(displayString: "Upload", fontSize: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AbsText(
                displayString: "Question: ${widget.index + 1}",
                fontSize: 16,
                bold: true),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: AbsMinimalBox(
                        layer: 1,
                        child:
                            AbsText(displayString: "Question", fontSize: 14))),
                const SizedBox(width: 8),
                Expanded(
                    flex: 5,
                    child: AbsMinimalBox(
                      layer: 1,
                      child: AbsText(
                          displayString: widget.question.query, fontSize: 14),
                    ))
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 1,
                    child: AbsMinimalBox(
                        layer: 1,
                        child: AbsText(
                            displayString: "Ideal answer", fontSize: 14))),
                const SizedBox(width: 8),
                Expanded(
                    flex: 5,
                    child: AbsMinimalBox(
                      layer: 1,
                      child: AbsText(
                          displayString: widget.question.idealAnswer!,
                          fontSize: 14),
                    ))
              ],
            ),
            const SizedBox(height: 8),
            if (isGenerating) ...[
              const Center(child: CircularProgressIndicator())
            ] else ...[
              if (widget.uploadedAnswer!.isEmpty) ...[
                SizedBox(
                    height: 100,
                    child: Row(
                      children: [
                        Expanded(
                          child: AbsMinimalBox(
                              layer: 1, child: Center(child: ocrImageButton())),
                        )
                      ],
                    ))
              ] else ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 1,
                        child: AbsMinimalBox(
                            layer: 1,
                            child: AbsText(
                                displayString: "Uploaded answer",
                                fontSize: 14))),
                    const SizedBox(width: 8),
                    Expanded(
                        flex: 5,
                        child: AbsMinimalBox(
                            layer: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: AbsText(
                                      displayString:
                                          "Uploaded answer: ${widget.uploadedAnswer!}",
                                      fontSize: 14),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      AbsButtonPrimary(
                                          onPressed: () {},
                                          child: Icon(Icons.edit)),
                                      const SizedBox(height: 7),
                                      AbsButtonPrimary(
                                          onPressed: () {},
                                          child:
                                              Icon(Icons.camera_alt_outlined))
                                    ],
                                  ),
                                ),
                              ],
                            ))),
                  ],
                ),
              ]
            ],
          ],
        )
        /*
      child: Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(227, 221, 211, 1),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12,
                  spreadRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Question: ${widget.index + 1}", style: TextStyle(
                      fontWeight: FontWeight.w700
                    ),),
                    const Spacer(),
                    Text(
                        "Final Score: ${widget.evaluatedScore == -1 ? "Not evaluated" : widget.evaluatedScore}")
                  ],
                ),
                const SizedBox(height: 10),
                Text("Question: ${widget.question.query}",style: TextStyle(
                      fontWeight: FontWeight.w700
                    )),
                const SizedBox(height: 10),
                Text("Ideal Answer: ${widget.question.idealAnswer}",style: TextStyle(
                      fontWeight: FontWeight.w500
                    )),
                const SizedBox(height: 10),
                if (isGenerating) ...[
                  const Center(child: CircularProgressIndicator())
                ] else ...[
                  if (widget.uploadedAnswer!.isEmpty) ...[
                    ocrImageButton()
                  ] else ...[
                    Text(widget.uploadedAnswer!)
                  ]
                ]
              ],
            ),
          )),*/
        );
  }
}
