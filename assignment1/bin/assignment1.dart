import 'dart:io';

import 'package:assignment1/trip_planner.dart' as trip_planner;

void main(List<String> arguments) {
  // Main code starts here...
  int iter = 0;
  print("Select packages for:");
  for (String category in trip_planner.packages.keys) {
    print("${++iter} $category");
  }
  iter = 0;
  String? categoryType = stdin.readLineSync();
  String category = "";
  switch (categoryType!) {
    case "1":
      category = "Individual";
      break;
    case "2":
      category = "Family";
      break;
    case "3":
      category = "Group";
      break;
    default:
      break;
  }
  print("Select packages:");
  for (String package in trip_planner.packages[category]!.keys) {
    print(
        "${++iter} $package - \$${trip_planner.packages[category]![package]}");
  }
  iter = 0;
  String? selectedPackage = stdin.readLineSync();
  
}
