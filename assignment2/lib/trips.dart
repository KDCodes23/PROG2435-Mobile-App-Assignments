// trips.dart
import 'main.dart';

/// Enum for trip types
enum TripType { individual, family, group }

/// Base Trip class
class Trip {
  final Destinations destination;
  final String contactPhone;
  final String email;
  final double price;

  Trip({
    required this.destination,
    required this.contactPhone,
    required this.email,
    required this.price,
  });

  // Base toString for common properties
  @override
  String toString() {
    return 'Destination: ${destination.name}, Contact Phone: $contactPhone, Email: $email, Price: \$${price.toStringAsFixed(2)}';
  }
}

/// IndividualTrip class with specific property: homeAddress
class IndividualTrip extends Trip {
  final String homeAddress;

  IndividualTrip({
    required Destinations destination,
    required String contactPhone,
    required String email,
    required double price,
    required this.homeAddress,
  }) : super(
          destination: destination,
          contactPhone: contactPhone,
          email: email,
          price: price,
        );

  @override
  String toString() {
    return '${super.toString()}, Home Address: $homeAddress';
  }
}

/// FamilyTrip class with specific property: primaryContact
class FamilyTrip extends Trip {
  final String primaryContact;

  FamilyTrip({
    required Destinations destination,
    required String contactPhone,
    required String email,
    required double price,
    required this.primaryContact,
  }) : super(
          destination: destination,
          contactPhone: contactPhone,
          email: email,
          price: price,
        );

  @override
  String toString() {
    return '${super.toString()}, Primary Contact: $primaryContact';
  }
}

/// GroupTrip class with specific property: groupInsuranceNumber
class GroupTrip extends Trip {
  final String groupInsuranceNumber;

  GroupTrip({
    required Destinations destination,
    required String contactPhone,
    required String email,
    required double price,
    required this.groupInsuranceNumber,
  }) : super(
          destination: destination,
          contactPhone: contactPhone,
          email: email,
          price: price,
        );

  @override
  String toString() {
    return '${super.toString()}, Group Insurance Number: $groupInsuranceNumber';
  }
}

/// TripManager class to handle booking and displaying trips
class TripManager {
  final List<Trip> _trips = [];

  /// Adds a trip to the trip list
  void addTrip(Trip trip) {
    _trips.add(trip);
  }

  /// Returns all trip details as a string
  String showAllTrips() {
    if (_trips.isEmpty) {
      return 'No trips have been booked.';
    }
    return _trips.map((trip) => trip.toString()).join('\n\n');
  }

  /// Calculates the total price of all trips
  double calculateTotalPrice() {
    return _trips.fold(0.0, (total, trip) => total + trip.price);
  }
}
