class Customer {
  String destination;
  String contactName;
  String contactPhone;
  double tripPrice;

  Customer(
      this.destination, this.contactName, this.contactPhone, this.tripPrice);
}

class Individual extends Customer {
  bool hasTravelInsurance = false;

  Individual(super.destination, super.contactName, super.contactPhone,
      super.tripPrice, this.hasTravelInsurance);
}

class Family extends Customer {
  bool hasCoverage = false;
  String insuranceCompany;

  Family(super.destination, super.contactName, super.contactPhone,
      super.tripPrice, this.hasCoverage, this.insuranceCompany);
}

class Group extends Customer {}
