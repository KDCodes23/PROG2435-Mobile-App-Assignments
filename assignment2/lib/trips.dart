/// Enum for Destination options
enum Destinations { blueMountain, niagaraFalls, banffNationalPark }

/// Enum for customer type
enum CustomerType { individual, family, group }

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

  /// Common properties for all trips
  @override
  String toString() =>
      'Destination: ${destination.name}, Contact Phone: $contactPhone, '
      'Email: $email, Price: \$${price.toStringAsFixed(2)}';
}

/// IndividualTrip class with specific property: homeAddress
class IndividualTrip extends Trip {
  final String homeAddress;

  IndividualTrip({
    required super.destination,
    required super.contactPhone,
    required super.email,
    required super.price,
    required this.homeAddress,
  });

  @override
  String toString() {
    return '${super.toString()}, Home Address: $homeAddress';
  }
}

/// FamilyTrip class with specific property: primaryContact
class FamilyTrip extends Trip {
  final String primaryContact;

  FamilyTrip({
    required super.destination,
    required super.contactPhone,
    required super.email,
    required super.price,
    required this.primaryContact,
  });

  @override
  String toString() {
    return '${super.toString()}, Primary Contact: $primaryContact';
  }
}

/// GroupTrip class with specific property: groupInsuranceNumber
class GroupTrip extends Trip {
  final String groupInsuranceNumber;

  GroupTrip({
    required super.destination,
    required super.contactPhone,
    required super.email,
    required super.price,
    required this.groupInsuranceNumber,
  });

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

  /// Returns all trip details as a formatted string
  String showAllTrips() {
    if (_trips.isEmpty) {
      return 'No trips have been booked.';
    }
    return _trips
        .asMap()
        .entries
        .map((entry) => 'Trip ${entry.key + 1}:\n${entry.value.toString()}')
        .join('\n\n');
  }

  /// Calculates the total price of all trips
  double calculateTotalPrice() {
    return _trips.fold(0.0, (total, trip) => total + trip.price);
  }

  /// Clears all trips (useful for resetting or starting a new booking session)
  void resetTrips() {
    _trips.clear();
  }
}
