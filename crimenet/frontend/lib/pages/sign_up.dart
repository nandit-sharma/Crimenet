import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? gender;
  String? occupation;
  String? state;
  String? city;
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
        title: Text('Sign Up', style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF00215E),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00215E), Color(0xFF2C4E80)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFFFC4100), Color(0xFFFFC55A)],
                  ),
                ),
                child: Icon(Icons.person_add, color: Colors.white, size: 48),
              ),
              SizedBox(height: 24),
              _styledTextField(_nameController, 'Full Name', Icons.person),
              SizedBox(height: 16),
              _styledTextField(
                _ageController,
                'Age',
                Icons.cake,
                isNumber: true,
              ),
              SizedBox(height: 16),
              _styledDropdown(
                'Gender',
                gender,
                genderOptions,
                (value) => setState(() => gender = value),
                Icons.wc,
              ),
              SizedBox(height: 16),
              _styledDropdown(
                'Occupation',
                occupation,
                occupationOptions,
                (value) => setState(() => occupation = value),
                Icons.work,
              ),
              SizedBox(height: 16),
              _styledDropdown('State', state, stateOptions, (value) {
                if (value != null) {
                  setState(() => state = value);
                  updateCities(value);
                }
              }, Icons.map),
              SizedBox(height: 16),
              _styledDropdown(
                'City',
                city,
                cityOptions,
                (value) => setState(() => city = value),
                Icons.location_city,
              ),
              SizedBox(height: 16),
              _styledTextField(_areaController, 'Area / Locality', Icons.home),
              SizedBox(height: 16),
              _styledTextField(
                _phoneController,
                'Phone Number',
                Icons.phone,
                isNumber: true,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFC4100),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _styledTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFFFC4100)),
        filled: true,
        fillColor: Color(0xFF2C4E80),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFFC4100)),
        ),
        labelStyle: TextStyle(color: Color(0xFFFFC55A)),
      ),
      style: TextStyle(color: Colors.white),
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
    );
  }

  Widget _styledDropdown(
    String label,
    String? value,
    List<String> options,
    ValueChanged<String?> onChanged,
    IconData icon,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFFFC4100)),
        filled: true,
        fillColor: Color(0xFF2C4E80),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFFFC4100)),
        ),
        labelStyle: TextStyle(color: Color(0xFFFFC55A)),
      ),
      dropdownColor: Color(0xFF2C4E80),
      style: TextStyle(color: Colors.white),
      items: options.map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value, style: TextStyle(color: Colors.white)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
