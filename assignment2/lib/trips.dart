enum Destinations { blueMountain, niagaraFalls, banffNationalPark }

abstract class Trip {
  final Destinations destination;
  final String contact;
  final String email;
  final double price;

  Trip({
    required this.destination,
    required this.contact,
    required this.email,
    required this.price,
  });

  double getTotalPrice() => price;

  @override
  String toString() {
    return 'Destination: ${destination.name}, Contact: $contact, Email: $email, Price: \$$price';
  }
}

class IndividualTrip extends Trip {
  final String homeAddress;

  IndividualTrip({
    required Destinations destination,
    required String contact,
    required String email,
    required double price,
    required this.homeAddress,
  }) : super(
          destination: destination,
          contact: contact,
          email: email,
          price: price,
        );

  @override
  String toString() {
    return '${super.toString()}, Home Address: $homeAddress';
  }
}

class FamilyTrip extends Trip {
  final String primaryContact;

  FamilyTrip({
    required Destinations destination,
    required String contact,
    required String email,
    required double price,
    required this.primaryContact,
  }) : super(
          destination: destination,
          contact: contact,
          email: email,
          price: price,
        );

  @override
  String toString() {
    return '${super.toString()}, Primary Contact: $primaryContact';
  }
}

class GroupTrip extends Trip {
  final String groupInsuranceNumber;

  GroupTrip({
    required Destinations destination,
    required String contact,
    required String email,
    required double price,
    required this.groupInsuranceNumber,
  }) : super(
          destination: destination,
          contact: contact,
          email: email,
          price: price,
        );

  @override
  String toString() {
    return '${super.toString()}, Group Insurance Number: $groupInsuranceNumber';
  }
}
