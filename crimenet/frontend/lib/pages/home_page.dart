import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Crime Solver', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: const Center(
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            _drawerItem(context, 'Profile', '/profile'),
            _drawerItem(context, 'Insights', '/insights'),
            _drawerItem(context, 'Feedback', '/feedback'),
            _drawerItem(context, 'Admin Panel', '/admin'),
            _drawerItem(context, 'Terms', '/terms'),
            _drawerItem(context, 'Privacy', '/privacy'),
            _drawerItem(context, 'Sign Up', '/sign_up'),
            _drawerItem(context, 'Login', '/login'),
            _drawerItem(context, 'Case Details', '/case_details'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _mainButton(context, 'Report Crime', '/report', Icons.report),
            _mainButton(context, 'AI Detective', '/ai_detective', Icons.psychology),
            _mainButton(context, 'Community', '/community', Icons.group),
            _mainButton(context, 'Recent Cases', '/recent_cases', Icons.history),
          ],
        ),
      ),
    );
  }

  Widget _mainButton(BuildContext context, String label, String route, IconData icon) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, route),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.all(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 12),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, String title, String route) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, route);
      },
    );
  }
}
