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
    print("\nSelect a valid package!");
    return getPackage(category);
  }
}

String getRequiredMaterials() {
  String requiredEquipment = "";

  print("\nAvailable equipments: ");
  for (String equip in equipment.keys) {
    print("${++iter} $equip - \$${equipment[equip]}");
  }
  iter = 0;
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
    case "5":
      requiredEquipment = "No equipment";
    default:
      print("\nSelect atleast one option!");
      requiredEquipment = getRequiredMaterials();
      print('--------------------\n');
      print(requiredEquipment);
      break;
  }
  return requiredEquipment;
}

void main(List<String> arguments) {
  // Main code starts here...
  String addMore = "y";
  List<Customer> customers = [];
  double totalTripsPrice = 0;

  while (addMore.toLowerCase() == "y") {
    bool validInput = true;
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
        while (true) {
          try {
            print("Enter your name: ");
            contactName = stdin.readLineSync();

            print("Enter your phone number: ");
            contactPhone = stdin.readLineSync();

            tripPrice = packages[category]![destination].toDouble();

            print("Enter your policy number: ");
            String? policyNumber = stdin.readLineSync();

            customers.add(Individual(destination, contactName!, contactPhone!,
                tripPrice, policyNumber!)
              ..bookTravel());
            break;
          } on ArgumentError catch (e) {
            print(e);
          }
        }
        break;
      case "2":
        category = "Family";

        print("Select packages:");
        destination = getPackage(category);
        while (true) {
          try {
            print("Enter name: ");
            contactName = stdin.readLineSync();

            print("Enter your phone number: ");
            contactPhone = stdin.readLineSync();

            tripPrice = packages[category]![destination].toDouble();

            print("Who is your insurance company? ");
            String? insuranceCompany = stdin.readLineSync();

            print("Enter name of family member staying in Canada: ");
            String? memberInCanada = stdin.readLineSync();

            customers.add(Family(destination, contactName!, contactPhone!,
                tripPrice, insuranceCompany!, memberInCanada!)
              ..bookTravel());
            break;
          } on ArgumentError catch (e) {
            print(e);
          }
        }
        break;
      case "3":
        category = "Group";

        print("Select packages:");
        destination = getPackage(category);
        while (true) {
          try {
            print("Enter group leader's name: ");
            contactName = stdin.readLineSync();

            print("Enter group leader's phone number: ");
            contactPhone = stdin.readLineSync();

            tripPrice = packages[category]![destination].toDouble();

            String materialRequired = getRequiredMaterials();
            tripPrice += equipment[materialRequired] ?? 0;
            customers.add(Group(destination, contactName!, contactPhone!,
                tripPrice, materialRequired)
              ..bookTravel());

            break;
          } on ArgumentError catch (e) {
            print(e);
          }
        }
        break;
      default:
        validInput = false;
        break;
    }
    if (!validInput) {
      print("\nSelect a valid group \n");
      continue;
    }

    // TODO: Remove customer details block
    print("\n----------Customer Details----------\n");
    for (Customer c in customers) {
      print(c.contactName);
      print(c.contactPhone);
      print(c.destination);
      print(c.tripPrice);
    }

    print("Add more packages (y/n)");
    addMore = stdin.readLineSync() ?? "";
  }
  for (Customer c in customers) {
    totalTripsPrice += c.tripPrice;
  }
  print("\nTotal price of all trips is: \$$totalTripsPrice");
}

// TODO: Add comments