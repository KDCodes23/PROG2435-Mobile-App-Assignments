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

String getRequiredMaterials() {
  String requiredEquipment = "";

  for (String equip in equipment.keys) {
    print("${++iter} $equip - \$${equipment[equip]}");
  }
  print("Select the equipment you need: ");
  String? equipNum = stdin.readLineSync();
  switch (equipNum) {
    case "1":
      requiredEquipment = "Whistle";
      break;
    case "2":
      requiredEquipment = "Flags";
      break;
    case "3":
      requiredEquipment = "Water bottles";
      break;
    case "4":
      requiredEquipment = "Rain coats";
      break;
    default:
      return requiredEquipment;
  }
  return requiredEquipment;
}

void main(List<String> arguments) {
  // Main code starts here...
  String? addMore;
  List<Customer> customers = [];
  do {
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
        customers.add(Individual(destination, contactName!, contactPhone!,
            tripPrice, policyNumber!));
        break;
      case "2":
        category = "Family";
        print("Select packages:");
        destination = getPackage(category);
        print("Enter your name: ");
        contactName = stdin.readLineSync();
        print("Enter your phone number: ");
        contactPhone = stdin.readLineSync();
        tripPrice = packages[category]![destination].toDouble();
        print("Who is your insurance company? ");
        String? insuranceCompany = stdin.readLineSync();
        print("Enter name of family member staying in Canada: ");
        String? memberInCanada = stdin.readLineSync();
        customers.add(Family(destination, contactName!, contactPhone!,
            tripPrice, insuranceCompany!, memberInCanada!));
        break;
      case "3":
        category = "Group";
        print("Select packages:");
        destination = getPackage(category);
        print("Enter your name: ");
        contactName = stdin.readLineSync();
        print("Enter your phone number: ");
        contactPhone = stdin.readLineSync();
        tripPrice = packages[category]![destination].toDouble();
        String materialRequired = getRequiredMaterials();        
        tripPrice += equipment[materialRequired]!;
        customers.add(Group(destination, contactName!, contactPhone!, tripPrice,
            materialRequired));
        break;
      default:
        break;
    }
    print("\n----------Customer Details----------\n");
    for (Customer c in customers) {
      print(c.contactName);
      print(c.contactPhone);
      print(c.destination);
      print(c.tripPrice);
    }
    print("Add more packages (y/n)");
    addMore = stdin.readLineSync();
  } while (addMore == 'y');
}
