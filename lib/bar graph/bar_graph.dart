import 'package:expense_tracker/bar%20graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final double? maxY;
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  const MyBarGraph(
      {super.key,
      required this.maxY,
      required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thuAmount,
      required this.friAmount,
      required this.satAmount});

  @override
  Widget build(BuildContext context) {
    // initialize the bar data
    BarData myBarData = BarData(
        sunAmount: sunAmount,
        monAmount: monAmount,
        tueAmount: tueAmount,
        wedAmount: wedAmount,
        thuAmount: thuAmount,
        friAmount: friAmount,
        satAmount: satAmount);
    myBarData.initializeData();

    return BarChart(BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          tooltipBorder: BorderSide(
            style: BorderStyle.solid
          ),
          getTooltipColor: (group) {
           return  Colors.grey.shade400;
          },
        )
      ),
      
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
            reservedSize: 30,
            getTitlesWidget: getBottomTitles,
            showTitles: true,
          )),
          show: true,
        ),
        gridData: FlGridData(
          show: false,
        ),
        borderData: FlBorderData(show: false),
        maxY: maxY,
        minY: 0,
        barGroups: myBarData.barData
            .map((data) => BarChartGroupData(x: data.x, barRods: [
                  BarChartRodData(
                      backDrawRodData: BackgroundBarChartRodData(
                          show: true, toY: maxY, color: Colors.grey[400]),
                      toY: data.y,
                      color:  const Color.fromARGB(255, 96, 96, 96),
                      width: 25,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)))
                ]))
            .toList()));
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 14);
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text(
        'Sun',
        style: style,
      );
      break;
    case 1:
      text = Text(
        'Mon',
        style: style,
      );
      break;
    case 2:
      text = Text(
        'Tue',
        style: style,
      );
      break;
    case 3:
      text = Text(
        'Wed',
        style: style,
      );
      break;
    case 4:
      text = Text(
        'Thu',
        style: style,
      );
      break;
    case 5:
      text = Text(
        'Fri',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'Sat',
        style: style,
      );
      break;
    default:
      text = Text('');
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}
