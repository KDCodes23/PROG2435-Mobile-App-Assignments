Map<String, Map> packages = {
  "Individual": {
    "Blue Mountain": 200,
    "Niagara Falls": 100,
    "Banff National Park": 300,
  },
  "Family": {
    "Blue Mountain": 400,
    "Niagara Falls": 300,
    "Banff National Park": 700,
  },
  "Group": {
    "Blue Mountain": 700,
    "Niagara Falls": 1000,
    "Banff National Park": 1300,
  }
};

Map<String, double> equipment = {
  "Whistle": 2,
  "Flags": 3,
  "Water bottles": 5,
  "Rain coats": 20,
};

class Customer {
  String destination;
  String contactName;
  String contactPhone;
  double tripPrice;

  Customer(
      this.destination, this.contactName, this.contactPhone, this.tripPrice);

  void bookTravel() {
    print("Travel booked for $contactName to $destination.");
  }

  void arrangeTransport() {
    print("Transport has been arranged for $contactName");
  }
}

class Individual extends Customer {
  String policyNumber;

  Individual(super.destination, super.contactName, super.contactPhone,
      super.tripPrice, this.policyNumber);

  @override
  void bookTravel() {
    super.bookTravel();
    print("$contactName's workplace has been notified");
    print("Your insurance policy number is: $policyNumber");
  }
}

class Family extends Customer {
  String insuranceCompany;
  String memberInCanada;

  Family(super.destination, super.contactName, super.contactPhone,
      super.tripPrice, this.insuranceCompany, this.memberInCanada);

  @override
  void bookTravel() {
    super.bookTravel();
    print("Health coverage is provided by $insuranceCompany");
    print("Family member remaining in Canada: $memberInCanada");
  }
}

class Group extends Customer {
  String materialRequired;

  Group(super.destination, super.contactName, super.contactPhone,
      super.tripPrice, this.materialRequired);

  @override
  void bookTravel() {
    super.bookTravel();
    print("Destination company notified! Group leader is: $contactName");
    print("Organized hardware:");
    print("Required Material: $materialRequired");
    }
}
