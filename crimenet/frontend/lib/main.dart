import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/onboarding.dart';
import 'pages/Log_in.dart';
import 'pages/home_page.dart';
import 'pages/case_details.dart';
import 'pages/community_page.dart';
import 'pages/insights_page.dart';
import 'pages/profile_page.dart';
import 'pages/report_crime.dart';
import 'pages/ai_detective.dart';
import 'pages/recent_cases.dart';
import 'pages/terms_page.dart';
import 'pages/privacy_page.dart';
import 'pages/feedback_page.dart';
import 'pages/admin_panel.dart';
import 'pages/sign_up.dart';
import 'pages/emergency.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crimenet',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFF00215E),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFFC4100),
          secondary: Color(0xFFFFC55A),
          background: Color(0xFF00215E),
          surface: Color(0xFF2C4E80),
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onBackground: Colors.white,
          onSurface: Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF2C4E80),
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFC4100),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFFFFC55A),
            textStyle: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF2C4E80),
          labelStyle: TextStyle(color: Color(0xFFFFC55A)),
          hintStyle: TextStyle(color: Color(0xFFFFC55A)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        cardTheme: CardThemeData(
          color: Color(0xFF2C4E80),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
        ),
        iconTheme: IconThemeData(color: Color(0xFFFFC55A)),
        dividerColor: Color(0xFFFFC55A),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/login': (context) => LoginPage(),
        '/sign_up': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/case_details': (context) => CaseDetailsPage(),
        '/community': (context) => CommunityPage(),
        '/insights': (context) => InsightsPage(),
        '/profile': (context) => ProfilePage(),
        '/report': (context) => ReportCrimePage(),
        '/ai_detective': (context) => AiDetectivePage(),
        '/recent_cases': (context) => RecentCasesPage(),
        '/terms': (context) => TermsPage(),
        '/privacy': (context) => PrivacyPage(),
        '/feedback': (context) => FeedbackPage(),
        '/admin': (context) => AdminPanelPage(),
        '/emergency': (context) => EmergencyPage(),
      },
    );
  }
}
