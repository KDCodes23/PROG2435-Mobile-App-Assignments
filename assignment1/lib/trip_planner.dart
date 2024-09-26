class Customer {
  String destination;
  String contactName;
  String contactPhone;
  double tripPrice;

  Customer(this.destination, this.contactName, this.contactPhone, this.tripPrice);  
}

class Individual extends Customer {
  String policyNumber;

  Individual(super.destination, super.contactName, super.contactPhone,
      super.tripPrice, this.policyNumber);
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
