import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'trips.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TripPlannerForm());
  }
}

class TripPlannerForm extends StatefulWidget {
  const TripPlannerForm({super.key});

  @override
  State<TripPlannerForm> createState() => _TripPlannerFormState();
}

class _TripPlannerFormState extends State<TripPlannerForm> {
  int customerType = -1;
  int destination = -1;
  String contactPhone = "";
  String emailAddress = "";
  double tripPrice = 0;
  String additionalInfo = "";
  String tripsListMessage = "";
  TripManager manager = TripManager();

  final form = FormGroup({
    'type': FormControl<int>(validators: [Validators.required]),
    'destination': FormControl<int>(validators: [
      Validators.required,
    ]),
    'contact': FormControl<String>(validators: [
      Validators.required,
      Validators.pattern(RegExp(r"\d{10}")),
      Validators.minLength(10),
      Validators.maxLength(10),
    ]),
    'email': FormControl<String>(validators: [
      Validators.required,
      Validators.email,
    ]),
    'price': FormControl<double>(validators: [
      Validators.required,
      Validators.min(0.0),
      Validators.max(1000.0)
    ]),
    'additionalInfo': FormControl<double>(validators: [Validators.required])
  });

  bookTrip() {
    if (form.valid) {
      customerType = form.control('type').value;
      destination = form.control('destination').value;
      contactPhone = form.control('contact').value ?? "";
      emailAddress = form.control('email').value ?? "";
      tripPrice = form.control('price').value ?? 0;
      additionalInfo = form.control('additionalInfo').value ?? "";
    }

    switch (CustomerType.values[customerType]) {
      case CustomerType.individual:
        IndividualTrip trip = IndividualTrip(
            destination: Destinations.values[destination],
            contactPhone: contactPhone,
            email: emailAddress,
            price: tripPrice,
            homeAddress: additionalInfo);
        manager.addTrip(trip);
        break;
      case CustomerType.family:
        FamilyTrip trip = FamilyTrip(
            destination: Destinations.values[destination],
            contactPhone: contactPhone,
            email: emailAddress,
            price: tripPrice,
            primaryContact: additionalInfo);
        manager.addTrip(trip);

        break;
      case CustomerType.group:
        GroupTrip trip = GroupTrip(
            destination: Destinations.values[destination],
            contactPhone: contactPhone,
            email: emailAddress,
            price: tripPrice,
            groupInsuranceNumber: additionalInfo);
        manager.addTrip(trip);
        break;
      default:
        break;
    }
  }

  showTrips() {
    String allTrips = manager.showAllTrips();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trip Planner Form"),
      ),
      body: ReactiveForm(
        formGroup: form,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ReactiveDropdownField(
                    key: const Key('CustomerType'),
                    formControlName: 'type',
                    hint: const Text("Please select customer type"),
                    items: [
                      DropdownMenuItem(
                        value: CustomerType.individual.index,
                        child: const Text("Individual"),
                      ),
                      DropdownMenuItem(
                        value: CustomerType.family.index,
                        child: const Text("Family"),
                      ),
                      DropdownMenuItem(
                        value: CustomerType.group.index,
                        child: const Text("Group"),
                      ),
                    ]),
                const SizedBox(height: 8),
                ReactiveDropdownField(
                    key: const Key('TripDestination'),
                    formControlName: 'destination',
                    hint: const Text("Please select your destination"),
                    items: [
                      DropdownMenuItem(
                        value: Destinations.blueMountain.index,
                        child: const Text("Blue Mountain"),
                      ),
                      DropdownMenuItem(
                        value: Destinations.niagaraFalls.index,
                        child: const Text("Niagara Falls"),
                      ),
                      DropdownMenuItem(
                        value: Destinations.banffNationalPark.index,
                        child: const Text("Banff National Park"),
                      ),
                    ]),
                const SizedBox(height: 8),
                ReactiveTextField(
                  key: const Key("ContactPhone"),
                  formControlName: "contact",
                  decoration: const InputDecoration(
                    labelText: "Contact Phone",
                  ),
                  textAlign: TextAlign.start,
                  style: const TextStyle(backgroundColor: Colors.white),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 8),
                ReactiveTextField(
                    key: const Key("EmailAddress"),
                    formControlName: "email",
                    decoration:
                        const InputDecoration(labelText: "Email Address"),
                    textAlign: TextAlign.start,
                    style: const TextStyle(backgroundColor: Colors.white),
                    keyboardType: TextInputType.text),
                const SizedBox(height: 8),
                ReactiveTextField(
                    key: const Key("TripPrice"),
                    formControlName: "price",
                    decoration: const InputDecoration(labelText: "Trip Price"),
                    textAlign: TextAlign.start,
                    style: const TextStyle(backgroundColor: Colors.white),
                    keyboardType: TextInputType.number),
                const SizedBox(height: 8),
                ReactiveTextField(
                    key: const Key("AdditionalInfo"),
                    formControlName: "additionalInfo",
                    decoration: const InputDecoration(
                        labelText: "Additional Information"),
                    textAlign: TextAlign.start,
                    style: const TextStyle(backgroundColor: Colors.white),
                    keyboardType: TextInputType.text),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FilledButton(
                        onPressed: bookTrip, child: const Text("Book Trip")),
                    const SizedBox(height: 10),
                    FilledButton(
                        onPressed: showTrips, child: const Text("See Trips"))
                  ],
                ),
                const SizedBox(height: 8),
                Text(tripsListMessage),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
