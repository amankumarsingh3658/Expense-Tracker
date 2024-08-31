import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  String name;
  String amount;
  DateTime date;
  Function(BuildContext)? deleteTapped;
  ExpenseTile(
      {super.key,
      required this.name,
      required this.amount,
      required this.date,
      required this.deleteTapped});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: StretchMotion(), children: [
        // delete Button
        SlidableAction(icon: Icons.delete, onPressed: deleteTapped)
      ]),
      child: ListTile(
        title: Text(name),
        trailing: Text('₹$amount'),
        subtitle: Text('${date.day}/${date.month}/${date.year}'),
      ),
    );
  }
}
