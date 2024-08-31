import 'package:expense_tracker/bar%20graph/bar_graph.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfTheWeek;
  const ExpenseSummary({super.key, required this.startOfTheWeek});

  // calculate max amount in the bar graph
  double calculateMax(
      ExpenseData value,
      String sunday,
      String monday,
      String tuesday,
      String wednesday,
      String thursday,
      String friday,
      String saturday) {
    double? max = 100;

    List<double> values = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];
    //sort from smallest to largest
    values.sort();

    //get Largest amount (which is at the end)
    max = values.last * 1.2;
    return max == 0 ? 100 : max;
  }

  // calculate the week total
  double total(ExpenseData value, String sunday, String monday, String tuesday,
      String wednesday, String thursday, String friday, String saturday) {
    List<double> allValues = [
      value.calculateDailyExpenseSummary()[sunday] ?? 0,
      value.calculateDailyExpenseSummary()[monday] ?? 0,
      value.calculateDailyExpenseSummary()[tuesday] ?? 0,
      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
      value.calculateDailyExpenseSummary()[thursday] ?? 0,
      value.calculateDailyExpenseSummary()[friday] ?? 0,
      value.calculateDailyExpenseSummary()[saturday] ?? 0,
    ];

    double total = 0;
    for (var i = 0; i < allValues.length; i++) {
      total += allValues[i];
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    //
    var height = MediaQuery.of(context).size.height;
    //get yyyymmdd for each day of the week
    String sunday =
        convertDateTimeToString(startOfTheWeek.add(Duration(days: 0)));
    String monday =
        convertDateTimeToString(startOfTheWeek.add(Duration(days: 1)));
    String tuesday =
        convertDateTimeToString(startOfTheWeek.add(Duration(days: 2)));
    String wednesday =
        convertDateTimeToString(startOfTheWeek.add(Duration(days: 3)));
    String thursday =
        convertDateTimeToString(startOfTheWeek.add(Duration(days: 4)));
    String friday =
        convertDateTimeToString(startOfTheWeek.add(Duration(days: 5)));
    String saturday =
        convertDateTimeToString(startOfTheWeek.add(Duration(days: 6)));

    return Consumer<ExpenseData>(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            // Week Total
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text("Week Total: "),
                  Text(
                      "₹${total(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday)}"),
                ],
              ),
            ),
            // Bar Graph
            SizedBox(
              height: height * 0.25,
              child: MyBarGraph(
                  maxY: calculateMax(value, sunday, monday, tuesday, wednesday,
                      thursday, friday, saturday),
                  sunAmount: value.calculateDailyExpenseSummary()[sunday] ?? 0,
                  monAmount: value.calculateDailyExpenseSummary()[monday] ?? 0,
                  tueAmount: value.calculateDailyExpenseSummary()[tuesday] ?? 0,
                  wedAmount:
                      value.calculateDailyExpenseSummary()[wednesday] ?? 0,
                  thuAmount:
                      value.calculateDailyExpenseSummary()[thursday] ?? 0,
                  friAmount: value.calculateDailyExpenseSummary()[friday] ?? 0,
                  satAmount:
                      value.calculateDailyExpenseSummary()[saturday] ?? 0),
            ),
          ],
        ),
      );
    });
  }
}
