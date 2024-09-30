import 'dart:io';
import 'package:assignment1/trip_planner.dart';

int iter = 0;
Map packageMapping = {
  "1": "Blue Mountain",
  "2": "Niagara Falls",
  "3": "Banff National Park"
};

String getPackage(String category) {
  for (String package in packages[category]!.keys) {
    print("${++iter} $package - \$${packages[category]![package]}");
  }
  iter = 0;
  print("Enter destination: ");
  String? destinationType = stdin.readLineSync();
  if (destinationType == "1" ||
      destinationType == "2" ||
      destinationType == "3") {
    return packageMapping[destinationType];
  } else {
    return getPackage(category);
  }
}

List<String> getRequiredMaterials() {
  List<String> requiredEquipments = [];
  while (true) {
    for (String equip in equipment.keys) {
      print("${++iter} $equip - \$${equipment[equip]}");
    }
    print("Select the equipment you need: ");
    String? equipNum = stdin.readLineSync();
    switch (equipNum) {
      case "1":
        requiredEquipments.add("Whistle");
        break;
      case "2":
        requiredEquipments.add("Flags");
        break;
      case "3":
        requiredEquipments.add("Water bottles");
        break;
      case "4":
        requiredEquipments.add("Rain coats");
        break;
      case "5":
        return requiredEquipments;
      default:
        return requiredEquipments;
    }
  }
}

void main(List<String> arguments) {
  // Main code starts here...
  List<Customer> customers = [];
  String destination;
  String? contactName;
  String? contactPhone;
  double tripPrice;

  print("Select packages for:");
  for (String category in packages.keys) {
    print("${++iter} $category");
  }
  iter = 0;
  print("Select package type: ");
  String? categoryType = stdin.readLineSync();
  String category = "";
  switch (categoryType!) {
    case "1":
      category = "Individual";
      print("Select packages:");
      destination = getPackage(category);
      print("Enter your name: ");
      contactName = stdin.readLineSync();
      print("Enter your phone number: ");
      contactPhone = stdin.readLineSync();
      tripPrice = packages[category]![destination].toDouble();
      print("Enter your policy number: ");
      String? policyNumber = stdin.readLineSync();
      customers.add(Individual(
          destination, contactName!, contactPhone!, tripPrice, policyNumber!));
      break;
    case "2":
      category = "Family";
      print("Select packages:");
      destination = getPackage(category);
      print("Enter name: ");
      contactName = stdin.readLineSync();
      print("Enter phone number: ");
      contactPhone = stdin.readLineSync();
      tripPrice = packages[category]![destination].toDouble();
      print("Who is your insurance company? ");
      String? insuranceCompany = stdin.readLineSync();
      print("Enter name of family member staying in Canada: ");
      String? memberInCanada = stdin.readLineSync();
      customers.add(Family(destination, contactName!, contactPhone!, tripPrice,
          insuranceCompany!, memberInCanada!));
      break;
    case "3":
      category = "Group";
      print("Select packages:");
      destination = getPackage(category);
      print("Enter the leader's name: ");
      contactName = stdin.readLineSync();
      print("Enter the leader's phone number: ");
      contactPhone = stdin.readLineSync();
      tripPrice = packages[category]![destination].toDouble();
      List<String> materialsRequired = getRequiredMaterials();
      for (String equip in equipment.keys) {
        tripPrice += equipment[equip]!;
      }
      customers.add(Group(destination, contactName!, contactPhone!, tripPrice,
          materialsRequired));
      break;
    default:
      break;
  }
  for (Customer c in customers) {
    print(c.contactName);
    print(c.contactPhone);
    print(c.destination);
    print(c.tripPrice);
  }
}
