import 'package:flutter/material.dart';
import '../widgets/shared_layout.dart';
import 'sign_up.dart';
import 'Log_in.dart';

class AuthService {
  bool isLoggedIn() {
    return false;
  }

  Map<String, String> getUserDetails() {
    if (isLoggedIn()) {
      return {
        'name': 'Jane Doe',
        'email': 'jane.doe@example.com',
        'bio':
            'Passionate about secure and intuitive app design. Flutter enthusiast!',
        'profilePicUrl': 'https://randomuser.me/api/portraits/women/75.jpg',
        'joinDate': 'January 15, 2023',
      };
    }
    return {};
  }
}

class ProfilePage extends StatelessWidget {
  final AuthService _authService = AuthService();
  ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    bool isAuthenticated = _authService.isLoggedIn();
    Map<String, String> userDetails = _authService.getUserDetails();
    return SharedLayout(
      currentIndex: -1,
      title: 'Profile',
      showBackButton: true,
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF101A30), Color(0xFF1E3050)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: isAuthenticated
                ? _buildUserProfile(context, userDetails)
                : _buildGuestProfile(context),
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile(
    BuildContext context,
    Map<String, String> userDetails,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFFC4100), Color(0xFFFFC55A)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFC4100).withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            padding: EdgeInsets.all(4),
            child: CircleAvatar(
              radius: 56,
              backgroundColor: Colors.white,
              backgroundImage:
                  userDetails['profilePicUrl'] != null &&
                      userDetails['profilePicUrl']!.isNotEmpty
                  ? NetworkImage(userDetails['profilePicUrl']!)
                  : null,
              child:
                  userDetails['profilePicUrl'] == null ||
                      userDetails['profilePicUrl']!.isEmpty
                  ? Icon(Icons.person, size: 60, color: Color(0xFF2C4E80))
                  : null,
            ),
          ),
          SizedBox(height: 24),
          Text(
            userDetails['name'] ?? 'N/A',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFC55A),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            userDetails['email'] ?? 'No email provided',
            style: TextStyle(fontSize: 17, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          Divider(color: Color(0xFFFC4100), indent: 40, endIndent: 40),
          SizedBox(height: 24),
          _buildProfileDetailSection(
            context,
            title: 'Bio',
            content: userDetails['bio'] ?? 'No bio available.',
            icon: Icons.article_outlined,
          ),
          SizedBox(height: 16),
          _buildProfileDetailSection(
            context,
            title: 'Member Since',
            content: userDetails['joinDate'] ?? 'Not specified',
            icon: Icons.calendar_today_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetailSection(
    BuildContext context, {
    required String title,
    required String content,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, color: Color(0xFFFC4100), size: 20),
            if (icon != null) SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF2C4E80), Color(0xFF101A30)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Color(0xFFFC4100), width: 1),
          ),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFFFFC55A),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildGuestProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFFC4100), Color(0xFFFFC55A)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFFC4100).withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            padding: EdgeInsets.all(4),
            child: CircleAvatar(
              radius: 48,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person_off_outlined,
                size: 60,
                color: Color(0xFF2C4E80),
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Guest Account',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFC55A),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Create an account or log in to view and manage your profile.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              icon: Icon(Icons.person_add_alt_1_outlined, color: Colors.white),
              label: Text('Sign Up', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFC4100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              icon: Icon(Icons.login_outlined, color: Color(0xFFFC4100)),
              label: Text('Log In', style: TextStyle(color: Color(0xFFFC4100))),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: BorderSide(color: Color(0xFFFC4100), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ),
        ],
      ),
    );
  }
}
