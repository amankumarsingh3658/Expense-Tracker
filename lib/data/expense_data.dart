import 'dart:math';

import 'package:expense_tracker/data/hive_database.dart';
import 'package:expense_tracker/datetime/date_time_helper.dart';
import 'package:expense_tracker/model/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseData extends ChangeNotifier {
  // List of all Expenses
  List<ExpenseItem> overallExpenseList = [];

  //Get expense List
  List<ExpenseItem> getExpenseList() {
    return overallExpenseList;
  }

  // prepare data to display
  final db = HiveDatabase();
  void prepareData() {
    //if there exists data, get it
    if (db.readData().isNotEmpty) {
      overallExpenseList = db.readData();
      print(overallExpenseList);
      notifyListeners();
    } else {
      overallExpenseList = [];
    }
  }

  //Add new expense
  void addNewExpense(ExpenseItem newExpense) {
    overallExpenseList.add(newExpense);
    db.saveData(overallExpenseList);
    notifyListeners();
  }

  //Delete expense
  void deleteExpense(ExpenseItem expense) {
    overallExpenseList.remove(expense);
    db.saveData(overallExpenseList);
    notifyListeners();
  }

  //get weekdays (mon,tue, etc) from date time object
  String getWeekdays(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  //get the date for start of the week
  DateTime startOfTheWeek() {
    DateTime? startOfWeek;

    //get todays date

    DateTime today = DateTime.now();

    // get to the nearest sunday backwards

    for (int i = 0; i < 7; i++) {
      if (getWeekdays(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  /*
  convert overall list of expenses into a daily expense summary

  ex 
   overall Expense list = 
    [
    [food,2024/01/30,15],
    [food,2024/01/30,10],
    [food,2024/01/31,14],
    ]

    => 
    [
    [2024/01/30 , 25],
    [2024/01/31 , 14],
    ]

  */

  Map<String, double> calculateDailyExpenseSummary() {
    Map<String, double> dailyExpenseSummary = {
      // date (yyyymmdd) : amount for that day
    };

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.date);
      double amount = double.parse(expense.amount);

      if (dailyExpenseSummary.containsKey(date)) {
        double currentAmount = dailyExpenseSummary[date]!;
        currentAmount += amount;
        dailyExpenseSummary[date] = currentAmount;
      } else {
        dailyExpenseSummary.addAll({date: amount});
      }
    }
    return dailyExpenseSummary;
  }
}
