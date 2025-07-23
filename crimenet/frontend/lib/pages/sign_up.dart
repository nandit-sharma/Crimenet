import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Text controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  // Dropdown values
  String? gender;
  String? occupation;
  String? state;
  String? city;

  // Dropdown options
  final genderOptions = ['Male', 'Female', 'Other'];
  final occupationOptions = [
    'Student',
    'Doctor',
    'Engineer',
    'Police',
    'Lawyer',
    'Teacher',
    'Employed',
    'Unemployed',
    'Retired',
    'Businessperson',
    'Other',
  ];

  Map<String, List<String>> stateCityMap = {};
  List<String> stateOptions = [];
  List<String> cityOptions = [];

  @override
  void initState() {
    super.initState();
    loadStateCityData();
  }

  Future<void> loadStateCityData() async {
    final String response = await rootBundle.loadString('assets/Data.json');
    final data = json.decode(response) as Map<String, dynamic>;
    setState(() {
      stateCityMap = data.map((k, v) => MapEntry(k, List<String>.from(v)));
      stateOptions = stateCityMap.keys.toList();
    });
  }

  void updateCities(String selectedState) {
    setState(() {
      cityOptions = stateCityMap[selectedState] ?? [];
      city = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Information'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Name
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Age
            TextFormField(
              controller: _ageController,
              decoration: const InputDecoration(
                labelText: 'Age',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Gender
            DropdownButtonFormField<String>(
              value: gender,
              decoration: const InputDecoration(
                labelText: 'Gender',
                border: OutlineInputBorder(),
              ),
              items: genderOptions.map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) => setState(() => gender = value),
            ),
            const SizedBox(height: 16),

            // Occupation
            DropdownButtonFormField<String>(
              value: occupation,
              decoration: const InputDecoration(
                labelText: 'Occupation',
                border: OutlineInputBorder(),
              ),
              items: occupationOptions.map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) => setState(() => occupation = value),
            ),
            const SizedBox(height: 16),

            // State
            DropdownButtonFormField<String>(
              value: state,
              decoration: const InputDecoration(
                labelText: 'State',
                border: OutlineInputBorder(),
              ),
              items: stateOptions.map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => state = value);
                  updateCities(value);
                }
              },
            ),
            const SizedBox(height: 16),

            // City
            DropdownButtonFormField<String>(
              value: city,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
              items: cityOptions.map((value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (value) => setState(() => city = value),
            ),
            const SizedBox(height: 16),

            // Area
            TextFormField(
              controller: _areaController,
              decoration: const InputDecoration(
                labelText: 'Area / Locality',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Phone
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () {
                print("User Info:");
                print("Name: ${_nameController.text}");
                print("Age: ${_ageController.text}");
                print("Gender: $gender");
                print("Occupation: $occupation");
                print("State: $state");
                print("City: $city");
                print("Area: ${_areaController.text}");
                print("Phone: ${_phoneController.text}");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
