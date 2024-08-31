import 'package:expense_tracker/components/expense_summary.dart';
import 'package:expense_tracker/components/expense_tile.dart';
import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/model/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // prepare the data on startup
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  // text controllers
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  // add New Expense
  void addNewExpense() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add New Expense"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Expense name
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Expense',
                    ),
                    controller: nameController,
                  ),
                  // Expense amount
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Amount'),
                    keyboardType: TextInputType.number,
                    controller: amountController,
                  ),
                ],
              ),
              actions: [
                // Save Button
                MaterialButton(
                  onPressed: save,
                  child: Text("Save"),
                ),
                // Cancel Button
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    clearControllers();
                  },
                  child: Text("Cancel"),
                )
              ],
            ));
  }

  // delete expense
  void deleteExpense(ExpenseItem expense) {
    Provider.of<ExpenseData>(context,listen: false).deleteExpense(expense);
  }

  // Save
  void save() {
    // Create Expense Item
    ExpenseItem newExpense = ExpenseItem(
        name: nameController.text,
        amount: amountController.text,
        date: DateTime.now());

    // Add The Expense Item
    if (nameController.text.isNotEmpty && amountController.text.isNotEmpty) {
      Provider.of<ExpenseData>(context, listen: false)
          .addNewExpense(newExpense);
    } else {
      null;
    }

    //pop Alert dialog after saving
    Navigator.pop(context);

    // clear controllers
    clearControllers();
  }

  // clear the controllers
  void clearControllers() {
    nameController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Expense Tracker"),
      ),
      backgroundColor: Colors.grey[300],
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: addNewExpense,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Consumer<ExpenseData>(
        builder: (context, value, child) {
          return ListView(
            children: [
              // Weekly Summary
              ExpenseSummary(startOfTheWeek: value.startOfTheWeek()),
              SizedBox(
                height: 10,
              ),
              // Expense List
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: value.getExpenseList().length,
                  itemBuilder: (context, index) {
                    return ExpenseTile(
                        deleteTapped: (_) {
                          deleteExpense(value.getExpenseList()[index]);
                        },
                        name: value.getExpenseList()[index].name,
                        amount: value.getExpenseList()[index].amount,
                        date: value.getExpenseList()[index].date);
                  })
            ],
          );
        },
      ),
    );
  }
}
