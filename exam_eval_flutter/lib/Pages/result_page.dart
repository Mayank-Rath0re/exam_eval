import 'package:exam_eval_client/exam_eval_client.dart';
import 'package:exam_eval_flutter/Components/abs_button_primary.dart';
import 'package:exam_eval_flutter/Components/abs_minimal_box.dart';
import 'package:exam_eval_flutter/Components/abs_text.dart';
import 'package:exam_eval_flutter/main.dart';
import 'package:fl_chart/fl_chart.dart';
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
  bool isLoadingResultData = false;
  List<Result> resultData = [];
  final values = [45.0, 60.0, 30.0, 80.0, 55.0];

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
    calculateAverage(result);
    setState(() {
      resultData = result;
      isLoadingResultData = false;
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
                                                                      isLoadingResultData =
                                                                          true;
                                                                    });
                                                                    // Go to next tab
                                                                    fetchResultData();
                                                                    setState(
                                                                        () {
                                                                      _tabController
                                                                          .index = 1;
                                                                    });
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
                                    child: completedResults.isEmpty ||
                                            resultData.isEmpty
                                        ? Center(
                                            child: AbsText(
                                                displayString:
                                                    "No Data To Display!",
                                                fontSize: 20))
                                        : isLoadingResultData
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                              flex: 1,
                                                              child:
                                                                  AbsMinimalBox(
                                                                      layer: 1,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          AbsText(
                                                                              displayString: "Average Score",
                                                                              fontSize: 16,
                                                                              bold: true),
                                                                          const Spacer(),
                                                                          AbsText(
                                                                              displayString: "$averageScore",
                                                                              fontSize: 16)
                                                                        ],
                                                                      ))),
                                                          const SizedBox(
                                                              height: 10),
                                                          Expanded(
                                                              flex: 4,
                                                              child:
                                                                  AbsMinimalBox(
                                                                      layer: 1,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                // Y-axis label: Student Count
                                                                                RotatedBox(
                                                                                  quarterTurns: -1,
                                                                                  child: Text("Student Count", style: TextStyle(fontSize: 14)),
                                                                                ),
                                                                                const SizedBox(width: 4),
                                                                                Expanded(
                                                                                  child: LineChart(
                                                                                    LineChartData(
                                                                                      minX: 0,
                                                                                      maxX: 50, // marks: 0 to 50
                                                                                      minY: 0,
                                                                                      maxY: 30, // student count: 0 to ~30
                                                                                      borderData: FlBorderData(
                                                                                        show: true,
                                                                                        border: const Border(
                                                                                          left: BorderSide(color: Colors.black, width: 1),
                                                                                          bottom: BorderSide(color: Colors.black, width: 1),
                                                                                        ),
                                                                                      ),
                                                                                      gridData: const FlGridData(show: false),
                                                                                      titlesData: FlTitlesData(
                                                                                        leftTitles: AxisTitles(
                                                                                          sideTitles: SideTitles(
                                                                                            showTitles: true,
                                                                                            interval: 5,
                                                                                            reservedSize: 36,
                                                                                            getTitlesWidget: (v, _) => Text('${v.toInt()}', style: TextStyle(fontSize: 10)),
                                                                                          ),
                                                                                        ),
                                                                                        bottomTitles: AxisTitles(
                                                                                          sideTitles: SideTitles(
                                                                                            showTitles: true,
                                                                                            interval: 10,
                                                                                            reservedSize: 32,
                                                                                            getTitlesWidget: (v, _) => Text('${v.toInt()}', style: TextStyle(fontSize: 10)),
                                                                                          ),
                                                                                        ),
                                                                                        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                                                        rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                                                      ),
                                                                                      lineBarsData: [
                                                                                        LineChartBarData(
                                                                                          spots: const [
                                                                                            FlSpot(10, 2),
                                                                                            FlSpot(20, 5),
                                                                                            FlSpot(30, 12),
                                                                                            FlSpot(35, 28),
                                                                                            FlSpot(40, 10),
                                                                                            FlSpot(45, 6),
                                                                                            FlSpot(50, 1),
                                                                                          ],
                                                                                          isCurved: true,
                                                                                          color: const Color(0xFF004d00),
                                                                                          barWidth: 2,
                                                                                          isStrokeCapRound: true,
                                                                                          dotData: FlDotData(
                                                                                            show: true,
                                                                                            getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                                                                                              radius: 3,
                                                                                              color: const Color(0xFF004d00),
                                                                                              strokeColor: Colors.transparent,
                                                                                            ),
                                                                                          ),
                                                                                          belowBarData: BarAreaData(show: false),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                              "Scored Marks",
                                                                              style: TextStyle(fontSize: 14)),
                                                                        ],
                                                                      ))),
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
                                                                shrinkWrap:
                                                                    true,
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
                                                                    thickness:
                                                                        2,
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          4),
                                                                  for (int i =
                                                                          0;
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
                                                                                resultData[i].name,
                                                                            fontSize: 14),
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
                                                              child:
                                                                  AbsMinimalBox(
                                                                      layer: 1,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          AbsText(
                                                                              displayString: "Best Scorer",
                                                                              fontSize: 16,
                                                                              bold: true),
                                                                          const Spacer(),
                                                                          AbsText(
                                                                              displayString: resultData[bestScorerIndex].name,
                                                                              fontSize: 16)
                                                                        ],
                                                                      ))),
                                                          const SizedBox(
                                                              height: 10),
                                                          Expanded(
                                                            flex: 4,
                                                            child: AbsMinimalBox(
                                                                layer: 1,
                                                                child: Center(
                                                                    child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8,
                                                                      vertical:
                                                                          8),
                                                                  child:
                                                                      AspectRatio(
                                                                    aspectRatio:
                                                                        1.5,
                                                                    child:
                                                                        BarChart(
                                                                      BarChartData(
                                                                        alignment:
                                                                            BarChartAlignment.spaceAround,
                                                                        maxY:
                                                                            100,
                                                                        minY: 0,
                                                                        barTouchData:
                                                                            BarTouchData(enabled: false),
                                                                        titlesData:
                                                                            FlTitlesData(
                                                                          leftTitles:
                                                                              AxisTitles(
                                                                            sideTitles:
                                                                                SideTitles(
                                                                              showTitles: true,
                                                                              interval: 20,
                                                                              reservedSize: 36,
                                                                              getTitlesWidget: (v, _) => Text(
                                                                                '${v.toInt()}%',
                                                                                style: const TextStyle(color: Colors.black54, fontSize: 12),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          bottomTitles:
                                                                              AxisTitles(
                                                                            sideTitles:
                                                                                SideTitles(
                                                                              showTitles: true,
                                                                              getTitlesWidget: (x, _) {
                                                                                const labels = [
                                                                                  'Q1',
                                                                                  'Q2',
                                                                                  'Q3',
                                                                                  'Q4',
                                                                                  'Q5'
                                                                                ];
                                                                                final i = x.toInt();
                                                                                return i >= 0 && i < labels.length ? Text(labels[i], style: const TextStyle(fontSize: 12)) : const SizedBox();
                                                                              },
                                                                            ),
                                                                          ),
                                                                          topTitles:
                                                                              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                                          rightTitles:
                                                                              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                                                        ),
                                                                        gridData: FlGridData(
                                                                            show:
                                                                                true,
                                                                            horizontalInterval:
                                                                                20),
                                                                        borderData:
                                                                            FlBorderData(
                                                                          show:
                                                                              true,
                                                                          border:
                                                                              const Border(
                                                                            left:
                                                                                BorderSide(color: Colors.black87, width: 1),
                                                                            bottom:
                                                                                BorderSide(color: Colors.black87, width: 1),
                                                                          ),
                                                                        ),
                                                                        barGroups: List.generate(
                                                                            values.length,
                                                                            (i) {
                                                                          return BarChartGroupData(
                                                                            x: i,
                                                                            barRods: [
                                                                              BarChartRodData(
                                                                                toY: values[i],
                                                                                color: Colors.teal[700],
                                                                                width: 20,
                                                                                borderRadius: BorderRadius.circular(4),
                                                                              ),
                                                                            ],
                                                                          );
                                                                        }),
                                                                        groupsSpace:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ))),
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
