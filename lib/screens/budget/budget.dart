import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wedding_planner/firebase_models/budget_model.dart';
import 'package:wedding_planner/themes.dart';
import 'package:wedding_planner/widgets/app_bar.dart';
import 'package:wedding_planner/widgets/submit_button.dart';
import 'package:wedding_planner/widgets/text_form_entry.dart';
import '../../firebase_state_management/budget_state.dart';
import '../../main.dart';
import '../../widgets/text_buttom_custom.dart';

class Budget extends StatefulWidget {
  const Budget({Key? key}) : super(key: key);

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  TextEditingController budgetTextController = TextEditingController();
  late TooltipBehavior _tooltipBehavior;

  init() async {
    await Provider.of<BudgetState>(context, listen: false).refreshBudgetData();
  }

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    init();
  }

  bool editClicked = false;
  // (Provider.of<BudgetState>(context, listen: false) == 0)
  //  ? editClicked = true
  // :else
  //   editClicked = false;
  //
  @override
  Widget build(BuildContext context) {
    final budgetState = Provider.of<BudgetState>(context);
    BudgetModel budget = budgetState.budget;
    final List<ChartData> chartData = [
      ChartData('Venue and Food', budget.venueAndFood),
      ChartData('Photographer', budget.photos),
      ChartData('Music', budget.music),
      ChartData('Flowers', budget.flowers),
      ChartData('Decor', budget.decor),
      ChartData('Attire', budget.attire),
      ChartData('Transport', budget.transport),
      ChartData('Stationary', budget.stationary),
      ChartData('Favours', budget.favours),
      ChartData('Cake', budget.cake),
    ];

    // bool editClicked;
    // if (budget.total == 0) {
    //   editClicked = true;
    // } else {
    //   editClicked = false;
    // }

    return Scaffold(
      appBar: WPAppBar(
        title: 'Budget',
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    width: (budget.total == 0 || editClicked)
                        ? displayWidth(context)
                        : displayWidth(context) * 0.9,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              width: (budget.total == 0 || editClicked)
                                  ? displayWidth(context) * 0.9
                                  : displayWidth(context) * 0.5,
                              child: TextFormField(
                                controller: budgetTextController,
                                cursorColor: AppColours.primary,
                                autofocus: editClicked,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'Please enter some text';
                                  //   }
                                  //   return null;
                                },
                                readOnly: !editClicked,
                                decoration: InputDecoration(
                                  hintText: (budget.total == 0)
                                      ? 'Enter your total budget'
                                      : 'R ${budget.total.toString().substring(0, 3)} ${budget.total.toString().substring(3, budget.total.toString().length)}',
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 16),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                        color: AppColours.pink, width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: const BorderSide(
                                      color: AppColours.primary,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: editClicked,
                              child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  child: SizedBox(
                                    width: displayWidth(context) * 0.9,
                                    child: SubmitButton(
                                      buttonName: 'Submit',
                                      onPressedFunction: () {
                                        budgetState.setBudgetData(
                                            budget: double.parse(
                                                budgetTextController.text));
                                        setState(() {
                                          budgetState.refreshBudgetData();
                                          editClicked = false;
                                        });
                                      },
                                    ),
                                  )),
                            )
                          ],
                        ),
                        Visibility(
                            visible: (budget.total != 0 && !editClicked),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: SizedBox(
                                width: displayWidth(context) * 0.3,
                                child: SubmitButton(
                                    buttonName: 'Edit total',
                                    onPressedFunction: () {
                                      setState(() {
                                        editClicked = true;
                                      });
                                    }),
                              ),
                              // child: InkWell(
                              //   onTap: () {
                              //     editClicked = false;
                              //   },
                              //   child: Text('Edit total'),
                              // ),
                            ))
                      ],
                    ),
                  ),
                  Visibility(
                    visible: (budget.total != 0),
                    child: SizedBox(
                      height: displayHeight(context) * 0.6,
                      child: SfCircularChart(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          tooltipBehavior: _tooltipBehavior,
                          palette: pieChartColors,
                          legend: Legend(
                            isVisible: true,
                            // legendItemBuilder: (String name, dynamic series,
                            //     dynamic point, int index) {
                            //   return Container(
                            //       height: 20,
                            //       width: 10,
                            //       child: Container(
                            //           child: Text(point.y.toString())));
                            // }

                            overflowMode: LegendItemOverflowMode.wrap,
// Legend will be placed at the bottom
                            position: LegendPosition.bottom,
                            textStyle: const TextStyle(
                                fontFamily: 'Roboto-Regular',
                                fontSize: 10,
                                overflow: TextOverflow.ellipsis),
                          ),
                          series: <CircularSeries>[
// Render pie chart
                            PieSeries<ChartData, String>(
                              enableTooltip: true,
                              animationDuration: 3000,
                              strokeColor: Colors.white,
                              strokeWidth: 1.5,
                              radius: '100',
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.x,
                              yValueMapper: (ChartData data, _) => data.y,
                              dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                              ),
                              dataLabelMapper: (ChartData data, _) =>
                                  '${(data.y / budget.total * 100).toInt().toString()}%',
                              groupMode: CircularChartGroupMode.point,
                              legendIconType: LegendIconType.circle,
// As the grouping mode is point, 2 points will be grouped
// dataLabelSettings: DataLabelSettings(
//     showZeroValue: false,
//     isVisible: true,
//     //     connectorLineSettings: const ConnectorLineSettings(
//     //         // Type of the connector line
//     //         width: 0),
//     //     // Templating the data label
//     builder: (dynamic data, dynamic point, dynamic series,
//         int pointIndex, int seriesIndex) {
//       return SvgPicture.network(
//         'https://mysmart.city/api/msc/images/custom/' +
//             data.iconString +
//             '?cityId=' +
//             widget.cityId.toString(),
//         width: 12,
//         height: 12,
//         color: ColorPalette.white,
//       );
//     })
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(
    this.x,
    this.y,
  );
  final String x;
  final double y;
}

// SfCircularChart(
// margin: const EdgeInsets.symmetric(horizontal: 16),
// tooltipBehavior: _tooltipBehavior,
// palette: widget.colors,
// legend: Legend(
// width: (displayWidth(context) * 0.4).toString(),
// isVisible: true,
// // Legend will be placed at the right
// position: LegendPosition.right,
// textStyle: const TextStyle(
// fontFamily: 'Roboto-Regular',
// fontSize: 10,
// overflow: TextOverflow.ellipsis),
// ),
// annotations: <CircularChartAnnotation>[
// CircularChartAnnotation(
// widget: PhysicalModel(
// shape: BoxShape.circle,
// color: Colors.white.withOpacity(0),
// child: Container())),
// CircularChartAnnotation(
// widget: Container(
// child: (_isNumeric(name))
// ? Column(
// mainAxisSize: MainAxisSize.min,
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text(
// 'Ward',
// style: TextStyle(
// fontFamily: 'Roboto-Regular',
// color: widget.colors.first,
// fontSize: 12),
// ),
// Text(
// name,
// style: TextStyle(
// fontFamily: 'Roboto-Medium',
// color: widget.colors.first,
// fontSize: 23),
// )
// ],
// )
// : Text(
// name,
// style: TextStyle(
// fontFamily: 'Roboto-Medium',
// color: widget.colors.first,
// fontSize: 23),
// )))
// ],
// series: <CircularSeries>[
// // Render pie chart
// DoughnutSeries<PieChartData, String>(
// enableTooltip: true,
// animationDuration: 3000,
// innerRadius: '60',
// strokeColor: Colors.white,
// strokeWidth: 1.5,
// radius: '100',
// dataSource: widget.pieDataList,
// xValueMapper: (PieChartData data, _) => data.x,
// yValueMapper: (PieChartData data, _) => data.y,
// dataLabelMapper: (PieChartData data, _) => data.iconString,
// groupMode: CircularChartGroupMode.point,
// legendIconType: LegendIconType.rectangle,
// // As the grouping mode is point, 2 points will be grouped
// // dataLabelSettings: DataLabelSettings(
// //     showZeroValue: false,
// //     isVisible: true,
// //     //     connectorLineSettings: const ConnectorLineSettings(
// //     //         // Type of the connector line
// //     //         width: 0),
// //     //     // Templating the data label
// //     builder: (dynamic data, dynamic point, dynamic series,
// //         int pointIndex, int seriesIndex) {
// //       return SvgPicture.network(
// //         'https://mysmart.city/api/msc/images/custom/' +
// //             data.iconString +
// //             '?cityId=' +
// //             widget.cityId.toString(),
// //         width: 12,
// //         height: 12,
// //         color: ColorPalette.white,
// //       );
// //     })
// )
// ]);