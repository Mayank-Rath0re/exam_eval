import 'package:exam_eval_client/exam_eval_client.dart';
import 'package:exam_eval_flutter/Components/abs_button_primary.dart';
import 'package:exam_eval_flutter/Components/abs_minimal_box.dart';
import 'package:exam_eval_flutter/Components/abs_text.dart';
import 'package:exam_eval_flutter/main.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final int userId;
  const ResultPage({super.key, required this.userId});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<ResultBatch> completedResults = [];
  late ResultBatch? selectedBatchForOverview;
  double averageScore = 0;
  int bestScorerIndex = 0;
  List<Result> resultData = [];

  bool isLoading = true;

  void getBuildData() async {
    var completed = await client.exam.fetchCompletedResults(widget.userId);
    setState(() {
      completedResults = completed;
      isLoading = false;
    });
  }

  void calculateAverage(List<Result> result) {
    var total = 0.0;
    var maxScoreIndex = 0;
    for (int i = 0; i < result.length; i++) {
      total += result[i].finalScore;
      if (result[i].finalScore > result[maxScoreIndex].finalScore) {
        maxScoreIndex = i;
      }
    }
    setState(() {
      averageScore = total / result.length;
      bestScorerIndex = maxScoreIndex;
    });
  }

  void fetchResultData() async {
    var result =
        await client.exam.fetchResultBatchById(selectedBatchForOverview!.id!);
    setState(() {
      resultData = result;
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    getBuildData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15.0,
        horizontal: 30,
      ),
      child: AbsMinimalBox(
          layer: 0,
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    AbsText(displayString: "Results", fontSize: 24, bold: true),
                    const SizedBox(height: 10),
                    AbsText(
                        displayString:
                            "view the outcomes of evaluations, showing detailed performance date and analytics.",
                        fontSize: 14),
                    const SizedBox(height: 10),
                    TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        onTap: (index) {
                          if (index == 1) {
                            calculateAverage(resultData);
                          }
                        },
                        tabs: [
                          AbsText(displayString: "Batches", fontSize: 14),
                          AbsText(displayString: "Overview", fontSize: 14),
                        ]),
                    const SizedBox(height: 10),
                    Expanded(
                        child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TabBarView(
                                controller: _tabController,
                                children: [
                                  if (completedResults.isEmpty) ...[
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const AbsText(
                                              displayString:
                                                  "No results available!",
                                              fontSize: 20,
                                              bold: true),
                                          const SizedBox(height: 20),
                                          AbsButtonPrimary(
                                              onPressed: () {},
                                              child: const AbsText(
                                                  displayString:
                                                      "Evaluate Result",
                                                  fontSize: 18))
                                        ],
                                      ),
                                    )
                                  ] else ...[
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 10,
                                      children: completedResults.map((batch) {
                                        DateTime date = batch.completedAt!;
                                        String dateString =
                                            "${date.day}/${date.month}/${date.year} - ${date.hour} : ${date.minute}";
                                        return AbsMinimalBox(
                                            layer: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  AbsText(
                                                      displayString:
                                                          batch.title,
                                                      fontSize: 20,
                                                      bold: true),
                                                  AbsText(
                                                      displayString:
                                                          "Completed at: $dateString",
                                                      fontSize: 15),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child:
                                                              AbsButtonPrimary(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      selectedBatchForOverview =
                                                                          batch;
                                                                    });
                                                                    // Go to next tab
                                                                  },
                                                                  child: AbsText(
                                                                      displayString:
                                                                          "View Overview",
                                                                      fontSize:
                                                                          18)))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ));
                                      }).toList(),
                                    )
                                  ],
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: completedResults.isEmpty
                                        ? Center(
                                            child: AbsText(
                                                displayString:
                                                    "No Data To Display!",
                                                fontSize: 20))
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                  flex: 4,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child: AbsMinimalBox(
                                                              layer: 1,
                                                              child: Row(
                                                                children: [
                                                                  AbsText(
                                                                      displayString:
                                                                          "Average Score",
                                                                      fontSize:
                                                                          16,
                                                                      bold:
                                                                          true),
                                                                  const Spacer(),
                                                                  AbsText(
                                                                      displayString:
                                                                          "$averageScore",
                                                                      fontSize:
                                                                          16)
                                                                ],
                                                              ))),
                                                      const SizedBox(
                                                          height: 10),
                                                      Expanded(
                                                          flex: 4,
                                                          child: AbsMinimalBox(
                                                              layer: 1,
                                                              child: Center(
                                                                  child: AbsText(
                                                                      displayString:
                                                                          "Graph Area",
                                                                      fontSize:
                                                                          20)))),
                                                    ],
                                                  )),
                                              const SizedBox(width: 15),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      child: AbsMinimalBox(
                                                          layer: 1,
                                                          child: ListView(
                                                            shrinkWrap: true,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  AbsText(
                                                                      displayString:
                                                                          "Name",
                                                                      fontSize:
                                                                          14,
                                                                      bold:
                                                                          true),
                                                                  AbsText(
                                                                      displayString:
                                                                          "Marks",
                                                                      fontSize:
                                                                          14,
                                                                      bold:
                                                                          true)
                                                                ],
                                                              ),
                                                              const Divider(
                                                                thickness: 2,
                                                              ),
                                                              const SizedBox(
                                                                  height: 4),
                                                              for (int i = 0;
                                                                  i <
                                                                      resultData
                                                                          .length;
                                                                  i++) ...[
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    AbsText(
                                                                        displayString:
                                                                            resultData[i]
                                                                                .name,
                                                                        fontSize:
                                                                            14),
                                                                    AbsText(
                                                                        displayString:
                                                                            "${resultData[i].finalScore}",
                                                                        fontSize:
                                                                            14)
                                                                  ],
                                                                ),
                                                                const Divider(
                                                                    thickness:
                                                                        1)
                                                              ]
                                                            ],
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 15),
                                              Expanded(
                                                  flex: 4,
                                                  child: Column(
                                                    children: [
                                                      Expanded(
                                                          flex: 1,
                                                          child: AbsMinimalBox(
                                                              layer: 1,
                                                              child: Row(
                                                                children: [
                                                                  AbsText(
                                                                      displayString:
                                                                          "Best Scorer",
                                                                      fontSize:
                                                                          16,
                                                                      bold:
                                                                          true),
                                                                  const Spacer(),
                                                                  AbsText(
                                                                      displayString:
                                                                          resultData[bestScorerIndex]
                                                                              .name,
                                                                      fontSize:
                                                                          16)
                                                                ],
                                                              ))),
                                                      const SizedBox(
                                                          height: 10),
                                                      Expanded(
                                                        flex: 4,
                                                        child: AbsMinimalBox(
                                                            layer: 1,
                                                            child: Center(
                                                                child: const AbsText(
                                                                    displayString:
                                                                        "Graph 2 Area - Question Wise",
                                                                    fontSize:
                                                                        20))),
                                                      ),
                                                    ],
                                                  ))
                                            ],
                                          ),
                                  )
                                ]))),
                  ],
                )),
    );
  }
}
