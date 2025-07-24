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
  Map<String, List<String>> stateCityMap = {};
  List<String> stateOptions = [];
  List<String> cityOptions = [];
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
      cityOptions = stateOptions.isNotEmpty
          ? stateCityMap[stateOptions[0]] ?? []
          : [];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (ModalRoute.of(context)?.settings.name != '/home') {
          Navigator.pushReplacementNamed(context, '/home');
          return false;
        }
        return true;
      },
      child: Scaffold(
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
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00215E), Color(0xFF2C4E80)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ListView(
              padding: EdgeInsets.only(top: 30),
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Color(0xFFFC4100),
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome',
                            style: TextStyle(
                              color: Color(0xFFFFC55A),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'User',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Color(0xFFFC4100),
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                _drawerMenuItem(
                  context,
                  Icons.insights,
                  'Insights',
                  '/insights',
                ),
                _drawerMenuItem(
                  context,
                  Icons.feedback,
                  'Feedback',
                  '/feedback',
                ),
                _drawerMenuItem(
                  context,
                  Icons.admin_panel_settings,
                  'Admin Panel',
                  '/admin',
                ),
                _drawerMenuItem(context, Icons.description, 'Terms', '/terms'),
                _drawerMenuItem(
                  context,
                  Icons.privacy_tip,
                  'Privacy',
                  '/privacy',
                ),
                _drawerMenuItem(
                  context,
                  Icons.folder_shared,
                  'Case Details',
                  '/case_details',
                ),
              ],
            ),
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
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF2C4E80),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF2C4E80).withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) =>
                            setState(() => searchQuery = value),
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
                    const SizedBox(height: 32),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: _mainButton(
                                  context,
                                  'Report Crime',
                                  '/report',
                                  Icons.report,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: _mainButton(
                                  context,
                                  'Emergency',
                                  '/emergency',
                                  Icons.warning,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF2C4E80),
          selectedItemColor: Color(0xFFFC4100),
          unselectedItemColor: Colors.white,
          currentIndex: 0,
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, '/home');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/recent_cases');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/community');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/ai_detective');
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Recent Cases',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Community',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.psychology), label: 'AI'),
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        splashColor: Color(0xFFFFC55A).withOpacity(0.2),
        highlightColor: Color(0xFFFC4100).withOpacity(0.1),
        onTap: () => Navigator.pushNamed(context, route),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF2C4E80),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF00215E).withOpacity(0.08),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 44, color: Color(0xFFFC4100)),
              const SizedBox(height: 16),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFFFFC55A)),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xFFFC4100),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        onTap: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
