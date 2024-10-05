import 'dart:io';
import 'package:assignment1/trip_planner.dart';

// Global iterable for printing index in menus
int iter = 0;

// Map object for package names
Map packageMapping = {
  "1": "Blue Mountain",
  "2": "Niagara Falls",
  "3": "Banff National Park"
};

/// Get input from user
String getInput(String prompt) {
  stdout.write(prompt);
  return stdin.readLineSync() ?? "";
}

/// Return package name
String getPackage(String category) {
  for (String package in packages[category]!.keys) {
    print("${++iter} $package - \$${packages[category]![package]}");
  }
  iter = 0;
  String destinationType = getInput("Enter destination: ");
  if (destinationType == "1" ||
      destinationType == "2" ||
      destinationType == "3") {
    return packageMapping[destinationType];
  } else {
    print("\nSelect a valid package!");
    return getPackage(category);
  }
}

/// Get required material for the trip.
///
/// Specific to Group trip booking.
String getRequiredMaterials() {
  String requiredEquipment = "";

  print("\nAvailable equipments: ");
  for (String equip in equipment.keys) {
    print("${++iter} $equip - \$${equipment[equip]}");
  }
  iter = 0;
  String equipNum = getInput("Select the equipment you need: ");
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

/// Handles booking for all three groups.
///
/// Params:
///
/// `category` -> String : Individual, Family, Group
///
/// `bookTrip` -> Function : Complete the leftout inputs and add a new customer to the customers list.
void handleBooking(String category, Function bookTrip) {
  print("Select packages:");
  String destination = getPackage(category);
  while (true) {
    try {
      String contactName = getInput("Enter your name: ");
      // Validation for name
      if (contactName.contains(RegExp(r"\d")) || contactName.isEmpty) {
        throw ArgumentError(
            "Customer name can only has letters and spaces", "customerName");
      }

      String contactPhone = getInput("Enter your phone number: ");
      // Validation for phone number
      if (contactPhone.length != 10 ||
          !contactPhone.contains(RegExp(r"\d{10}"))) {
        throw ArgumentError(
            "Phone number can only have 10 digits. Example: 9876543210",
            "contactPhone");
      }
      double tripPrice = packages[category]![destination].toDouble();

      bookTrip(destination, contactName, contactPhone, tripPrice);
      break;
    } on ArgumentError catch (e) {
      print(e);
    }
  }
}

void main(List<String> arguments) {
  // Main code starts here...
  String addMore = "y";
  List<Customer> customers = [];
  double totalTripsPrice = 0;

  while (addMore.toLowerCase() == "y") {
    bool validInput = true;

    print("Select packages for:");
    for (String category in packages.keys) {
      print("${++iter} $category");
    }
    iter = 0;
    String? categoryType = getInput("Select package type: ");
    switch (categoryType) {
      case "1":
        handleBooking("Individual",
            (destination, contactName, contactPhone, tripPrice) {
          String policyNumber = getInput("Enter your policy number: ");
          customers.add(Individual(
              destination, contactName, contactPhone, tripPrice, policyNumber)
            ..bookTravel());
        });

        break;
      case "2":
        handleBooking("Family",
            (destination, contactName, contactPhone, tripPrice) {
          String insuranceCompany = getInput("Who is your insurance company? ");

          String memberInCanada =
              getInput("Enter name of family member staying in Canada: ");

          customers.add(Family(destination, contactName!, contactPhone!,
              tripPrice, insuranceCompany, memberInCanada)
            ..bookTravel());
        });
        break;
      case "3":
        handleBooking("Group",
            (destination, contactName, contactPhone, tripPrice) {
          String materialRequired = getRequiredMaterials();
          tripPrice += equipment[materialRequired] ?? 0;
          customers.add(Group(destination, contactName, contactPhone, tripPrice,
              materialRequired)
            ..bookTravel());
        });
        break;
      default:
        validInput = false;
        break;
    }
    if (!validInput) {
      print("\nSelect a valid group \n");
      continue;
    }
    addMore = getInput("\nAdd more packages (y/n)");
  }
  print("\n----------Customer Details----------\n");
  print("Total customers:  ${customers.length}\n");
  for (Customer c in customers) {
    print("Category: ${c.runtimeType}");
    print(c.contactName);
    print(c.contactPhone);
    print(c.destination);
    print(c.tripPrice);
    print("");
    totalTripsPrice += c.tripPrice;
  }
  print("Total price of all trips is: \$$totalTripsPrice");
}
