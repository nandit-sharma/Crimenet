import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  String? selectedState;
  String? selectedCity;
  String? selectedType;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  Map<String, List<String>> stateCityMap = {};
  List<String> stateOptions = [];
  List<String> cityOptions = [];
  final List<String> types = ['Theft', 'Murder', 'Other'];
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
      selectedState = stateOptions.isNotEmpty ? stateOptions[0] : null;
      cityOptions = selectedState != null
          ? stateCityMap[selectedState!] ?? []
          : [];
      selectedCity = cityOptions.isNotEmpty ? cityOptions[0] : null;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ᴄ ʀ ɪ ᴍ ᴇ ɴ ᴇ ᴛ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF00215E),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color(0xFF00215E),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF2C4E80)),
              child: const Center(
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            _drawerItem(context, 'Insights', '/insights'),
            _drawerItem(context, 'Feedback', '/feedback'),
            _drawerItem(context, 'Admin Panel', '/admin'),
            _drawerItem(context, 'Terms', '/terms'),
            _drawerItem(context, 'Privacy', '/privacy'),
            _drawerItem(context, 'Case Details', '/case_details'),
          ],
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFFFC4100)),
            )
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF2C4E80),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF00215E).withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      onChanged: (value) => setState(() => searchQuery = value),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search for crimes...',
                        hintStyle: const TextStyle(color: Color(0xFFFFC55A)),
                        border: InputBorder.none,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Color(0xFFFC4100),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Filters
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
                          color: Color(0xFF00215E).withOpacity(0.08),
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
                            color: Color(0xFF00215E),
                          ),
                          const SizedBox(width: 8),
                          _filterDropdown(
                            'City',
                            cityOptions,
                            selectedCity,
                            (v) => setState(() => selectedCity = v),
                            color: Color(0xFF00215E),
                          ),
                          const SizedBox(width: 8),
                          _filterDropdown(
                            'Type',
                            types,
                            selectedType,
                            (v) => setState(() => selectedType = v),
                            color: Color(0xFF2C4E80),
                          ),
                          const SizedBox(width: 8),
                          _dateFilter(context),
                          const SizedBox(width: 8),
                          _timeFilter(context),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: [
                        _mainButton(
                          context,
                          'Report Crime',
                          '/report',
                          Icons.report,
                        ),
                        _mainButton(
                          context,
                          'AI Detective',
                          '/ai_detective',
                          Icons.psychology,
                        ),
                        _mainButton(
                          context,
                          'Community',
                          '/community',
                          Icons.group,
                        ),
                        _mainButton(
                          context,
                          'Recent Cases',
                          '/recent_cases',
                          Icons.history,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _mainButton(
    BuildContext context,
    String label,
    String route,
    IconData icon,
  ) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF2C4E80),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(16),
        elevation: 4,
        shadowColor: Color(0xFF00215E),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Color(0xFFFC4100)),
          const SizedBox(height: 12),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, String title, String route) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFFFC55A),
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: Color(0xFFFC4100),
      ),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
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
        dropdownColor: color,
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
