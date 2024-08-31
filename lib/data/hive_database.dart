import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/model/expense_item.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  // reference the box
  final _myBox = Hive.box("expense_database");

  // write data;

  void saveData(List<ExpenseItem> allExpense) {
    /*
  Since hive can only store Strings and Date time objects and no custom objects
  We need to convert each object in a storable type

  [
  [name,date,amount]
  ]
    */

    List<List<dynamic>> allExpenseFormatted = [];
    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.date,
        expense.amount
      ];
      allExpenseFormatted.add(expenseFormatted);
    }
    _myBox.put("All_Expenses", allExpenseFormatted);
  }

  List<ExpenseItem> readData() {
    /*
    data is stored as List of String date name
    so first we need to convert it
    */
    List savedData = _myBox.get("All_Expenses") ?? [];

    List<ExpenseItem> allExpense = [];

    for (int i = 0; i < savedData.length; i++) {
      // collect the individual expense data
      String name = savedData[i][0];
      DateTime date = savedData[i][1];
      String amount = savedData[i][2];

      // Create expense item
      ExpenseItem expenseItem =
          ExpenseItem(name: name, amount: amount, date: date);

      // add expense to overall list of expense
      allExpense.add(expenseItem);
    }
    return allExpense;
  }
}
