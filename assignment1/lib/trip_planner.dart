import 'dart:collection';

class Customer {
  String destination;
  String contactName;
  String contactPhone;
  double tripPrice;

  Customer(
      this.destination, this.contactName, this.contactPhone, this.tripPrice);
}

class Individual extends Customer {
  String policyNumber;

  Individual(super.destination, super.contactName, super.contactPhone,
      super.tripPrice, this.policyNumber);

  void NotifyWorkplace() {
    print("Your workplace has been notified");
  }
}

class Family extends Customer {
  String insuranceCompany;

  Family(super.destination, super.contactName, super.contactPhone,
      super.tripPrice, this.insuranceCompany);
}

class Group extends Customer {
  String materialRequired;

  Group(super.destination, super.contactName, super.contactPhone,
      super.tripPrice, this.materialRequired);
}

Map<String, Map> packages = {
  "Individual": {"Blue Mountain": 200,
                 "Niagara": 100,
                 "Banff National Park": 300,
                 },
  "Family": {"Blue Mountain": 400,
                 "Niagara": 300,
                 "Banff National Park": 700,
                 },
  "Group": {"Blue Mountain": 700,
                 "Niagara": 1000,
                 "Banff National Park": 1300,
                 }
};
