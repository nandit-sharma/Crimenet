import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import '../widgets/modern_button.dart';

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
      selectedState = null;
      cityOptions = [];
      selectedCity = null;
      isLoading = false;
    });
  }

  void updateCities(String? state) {
    setState(() {
      selectedState = state;
      cityOptions = state != null ? stateCityMap[state] ?? [] : [];
      selectedCity = null;
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
          ),
          title: Text(
            'Recent Cases Solved',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xFFFC4100)))
            : Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF101A30), Color(0xFF1E3050)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: ListView(
                    padding: EdgeInsets.only(
                      top: 16,
                      left: 20,
                      right: 20,
                      bottom: 0,
                    ),
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF2C4E80), Color(0xFF101A30)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF2C4E80).withOpacity(0.08),
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: selectedState,
                                    isExpanded: true,
                                    items: stateOptions
                                        .map(
                                          (s) => DropdownMenuItem(
                                            value: s,
                                            child: Text(
                                              s,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) => updateCities(v),
                                    decoration: InputDecoration(
                                      labelText: 'State',
                                      hintText: 'State',
                                      prefixIcon: Icon(
                                        Icons.map,
                                        color: Color(0xFFFC4100),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF1E3050),
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Color(0xFFFC4100),
                                        ),
                                      ),
                                    ),
                                    dropdownColor: Color(0xFF1E3050),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: selectedCity,
                                    isExpanded: true,
                                    items: cityOptions
                                        .map(
                                          (c) => DropdownMenuItem(
                                            value: c,
                                            child: Text(
                                              c,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) =>
                                        setState(() => selectedCity = v),
                                    decoration: InputDecoration(
                                      labelText: 'City',
                                      hintText: 'City',
                                      prefixIcon: Icon(
                                        Icons.location_city,
                                        color: Color(0xFFFC4100),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF1E3050),
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Color(0xFFFC4100),
                                        ),
                                      ),
                                    ),
                                    dropdownColor: Color(0xFF1E3050),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    value: selectedType,
                                    isExpanded: true,
                                    items: types
                                        .map(
                                          (t) => DropdownMenuItem(
                                            value: t,
                                            child: Text(
                                              t,
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (v) =>
                                        setState(() => selectedType = v),
                                    decoration: InputDecoration(
                                      labelText: 'Type',
                                      hintText: 'Type',
                                      prefixIcon: Icon(
                                        Icons.category,
                                        color: Color(0xFFFC4100),
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFF1E3050),
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                      ),
                                      hintStyle: TextStyle(
                                        color: Colors.white70,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Color(0xFFFC4100),
                                        ),
                                      ),
                                    ),
                                    dropdownColor: Color(0xFF1E3050),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      final picked = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            selectedDate ?? DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (picked != null)
                                        setState(() => selectedDate = picked);
                                    },
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        labelText: 'Date',
                                        prefixIcon: Icon(
                                          Icons.date_range,
                                          color: Color(0xFFFC4100),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFF1E3050),
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFFC4100),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        selectedDate == null
                                            ? 'Select Date'
                                            : '${selectedDate!.toLocal()}'
                                                  .split(' ')[0],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: InkWell(
                                    onTap: () async {
                                      final picked = await showTimePicker(
                                        context: context,
                                        initialTime:
                                            selectedTime ?? TimeOfDay.now(),
                                      );
                                      if (picked != null)
                                        setState(() => selectedTime = picked);
                                    },
                                    child: InputDecorator(
                                      decoration: InputDecoration(
                                        labelText: 'Time',
                                        prefixIcon: Icon(
                                          Icons.access_time,
                                          color: Color(0xFFFC4100),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFF1E3050),
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0xFFFC4100),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        selectedTime == null
                                            ? 'Select Time'
                                            : selectedTime!.format(context),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      // ... rest of the list ...
                    ],
                  ),
                ),
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
