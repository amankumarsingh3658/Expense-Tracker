import 'package:expense_tracker/bar%20graph/individual_bar.dart';

class BarData {
  // amount for each day

  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  BarData(
      {required this.sunAmount,
      required this.monAmount,
      required this.tueAmount,
      required this.wedAmount,
      required this.thuAmount,
      required this.friAmount,
      required this.satAmount});

  List<IndividualBar> barData = [];
  //initialize the data in the list

  void initializeData() {
    barData = [
      //sun
      IndividualBar(x: 0, y: sunAmount),
      //mon
      IndividualBar(x: 1, y: monAmount),
      //tue
      IndividualBar(x: 2, y: tueAmount),
      //wed
      IndividualBar(x: 3, y: wedAmount),
      //thu
      IndividualBar(x: 4, y: thuAmount),
      //fri
      IndividualBar(x: 5, y: friAmount),
      //sat
      IndividualBar(x: 6, y: satAmount),
    ];
  }
}
