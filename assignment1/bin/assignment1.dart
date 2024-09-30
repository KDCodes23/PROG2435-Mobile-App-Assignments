import 'dart:io';
import 'package:assignment1/trip_planner.dart';

void showPackages(String category) {
  int iter = 0;
  for (String package in packages[category]!.keys) {
    print("${++iter} $package - \$${packages[category]![package]}");
  }
}

void main(List<String> arguments) {
  // Main code starts here...
  List<Customer> customers = [];
  int iter = 0;
  print("Select packages for:");
  for (String category in packages.keys) {
    print("${++iter} $category");
  }
  iter = 0;
  String? categoryType = stdin.readLineSync();
  String category = "";
  switch (categoryType!) {
    case "1":
      category = "Individual";
      print("Select packages:");
      showPackages(category);
      break;
    case "2":
      category = "Family";
      print("Select packages:");
      showPackages(category);
      break;
    case "3":
      category = "Group";
      print("Select packages:");
      showPackages(category);
      break;
    default:
      break;
  }
}
