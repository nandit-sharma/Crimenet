import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class RecentCasesPage extends StatefulWidget {
  @override
  State<RecentCasesPage> createState() => _RecentCasesPageState();
}

class _RecentCasesPageState extends State<RecentCasesPage> {
  String? selectedState;
  String? selectedCity;
  String? selectedType;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Map<String, List<String>> stateCityMap = {};
  List<String> stateOptions = [];
  List<String> cityOptions = [];
  final List<String> types = ['Theft', 'Murder', 'Rape', 'Missing', 'Other'];
  bool isLoading = true;

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
      selectedState = stateOptions.contains('J&K')
          ? 'J&K'
          : (stateOptions.isNotEmpty ? stateOptions[0] : null);
      cityOptions = selectedState != null
          ? stateCityMap[selectedState!] ?? []
          : [];
      selectedCity = cityOptions.contains('Jammu')
          ? 'Jammu'
          : (cityOptions.isNotEmpty ? cityOptions[0] : null);
      isLoading = false;
    });
  }

  void updateCities(String? state) {
    setState(() {
      selectedState = state;
      cityOptions = state != null ? stateCityMap[state] ?? [] : [];
      selectedCity = cityOptions.isNotEmpty ? cityOptions[0] : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/home');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
          ),
          title: Text(
            'Recent Cases Solved',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xFFFC4100)))
            : ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF2C4E80),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF2C4E80).withOpacity(0.08),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _filterDropdown(
                            'State',
                            stateOptions,
                            selectedState,
                            (v) => updateCities(v),
                            color: Color(0xFF2C4E80),
                          ),
                          SizedBox(width: 8),
                          _filterDropdown(
                            'City',
                            cityOptions,
                            selectedCity,
                            (v) => setState(() => selectedCity = v),
                            color: Color(0xFF2C4E80),
                          ),
                          SizedBox(width: 8),
                          _filterDropdown(
                            'Type',
                            types,
                            selectedType,
                            (v) => setState(() => selectedType = v),
                            color: Color(0xFF2C4E80),
                          ),
                          SizedBox(width: 8),
                          _dateFilter(context),
                          SizedBox(width: 8),
                          _timeFilter(context),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: Color(0xFFFC4100),
                      ),
                      title: Text(
                        'Case 1',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Solved',
                        style: TextStyle(color: Color(0xFFFFC55A)),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.check_circle,
                        color: Color(0xFFFC4100),
                      ),
                      title: Text(
                        'Case 2',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Solved',
                        style: TextStyle(color: Color(0xFFFFC55A)),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _filterDropdown(
    String label,
    List<String> items,
    String? value,
    ValueChanged<String?> onChanged, {
    Color color = const Color(0xFF2C4E80),
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFFC4100), width: 1),
      ),
      child: DropdownButton<String>(
        value: value,
        hint: Text(label, style: const TextStyle(color: Colors.white)),
        dropdownColor: Color(0xFF2C4E80),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
        underline: Container(),
        style: const TextStyle(color: Colors.white),
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e, style: const TextStyle(color: Colors.white)),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _dateFilter(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) setState(() => selectedDate = picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFF2C4E80),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFFC4100), width: 1),
        ),
        child: Row(
          children: [
            const Icon(Icons.date_range, color: Color(0xFFFC4100)),
            const SizedBox(width: 4),
            Text(
              selectedDate == null
                  ? 'Date'
                  : '${selectedDate!.toLocal()}'.split(' ')[0],
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeFilter(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: selectedTime ?? TimeOfDay.now(),
        );
        if (picked != null) setState(() => selectedTime = picked);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Color(0xFF2C4E80),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFFFC4100), width: 1),
        ),
        child: Row(
          children: [
            const Icon(Icons.access_time, color: Color(0xFFFC4100)),
            const SizedBox(width: 4),
            Text(
              selectedTime == null ? 'Time' : selectedTime!.format(context),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
