import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import '../widgets/modern_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String searchQuery = '';
  Map<String, List<String>> stateCityMap = {};
  List<String> stateOptions = [];
  List<String> cityOptions = [];
  bool isLoading = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
    loadStateCityData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          title: Text(
            'C R I M E N E T',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle, color: Color(0xFFFFD180)),
              onPressed: () => Navigator.pushNamed(context, '/profile'),
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0A1C3A), Color(0xFF1E3050)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ListView(
              padding: EdgeInsets.only(top: 40),
              children: [
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFFFF3D00),
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
                              style: GoogleFonts.poppins(
                                color: Color(0xFFFFD180),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'User',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Color(0xFFFFD180),
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
                _drawerMenuItem(
                  context,
                  Icons.history,
                  'AI History',
                  '/ai_history',
                ),
              ],
            ),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: Color(0xFFFF3D00)))
            : Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF1E3050), Color(0xFF0A1C3A)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          onChanged: (value) =>
                              setState(() => searchQuery = value),
                          style: GoogleFonts.roboto(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Search for crimes...',
                            hintStyle: GoogleFonts.roboto(
                              color: Color(0xFFFFD180).withOpacity(0.7),
                            ),
                            border: InputBorder.none,
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Color(0xFFFF3D00),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF1E3050), Color(0xFF0A1C3A)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Recent Alerts',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFFFD180),
                              ),
                            ),
                            SizedBox(height: 8),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return SlideTransition(
                                  position:
                                      Tween<Offset>(
                                        begin: Offset(0.1 * (index + 1), 0),
                                        end: Offset.zero,
                                      ).animate(
                                        CurvedAnimation(
                                          parent: _controller,
                                          curve: Curves.easeOut,
                                        ),
                                      ),
                                  child: Card(
                                    child: ListTile(
                                      title: Text(
                                        'Alert: Suspicious Activity in [City]',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        'Reported on ${DateTime.now().toLocal()}',
                                        style: GoogleFonts.roboto(
                                          color: Color(0xFFFFD180),
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.warning,
                                        color: Color(0xFFFF3D00),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Expanded(
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: ElevatedButton.icon(
                                      icon: Icon(
                                        Icons.report,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Report Crime',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFFC4100),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                        ),
                                      ),
                                      onPressed: () => Navigator.pushNamed(
                                        context,
                                        '/report',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 56,
                                    child: ElevatedButton.icon(
                                      icon: Icon(
                                        Icons.warning,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Emergency',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFFC4100),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            18,
                                          ),
                                        ),
                                      ),
                                      onPressed: () => Navigator.pushNamed(
                                        context,
                                        '/emergency',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color(0xFF1E3050),
          selectedItemColor: Color(0xFFFF3D00),
          unselectedItemColor: Colors.white.withOpacity(0.7),
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

  Widget _drawerMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: ListTile(
          leading: Icon(icon, color: Color(0xFFFFD180)),
          title: Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Color(0xFFFF3D00),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, route);
          },
        ),
      ),
    );
  }
}
