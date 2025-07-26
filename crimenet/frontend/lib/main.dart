import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/splash_screen.dart';
import 'pages/onboarding.dart';
import 'pages/log_in.dart';
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
        scaffoldBackgroundColor: Color(0xFF0A1C3A),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFFF3D00),
          secondary: Color(0xFFFFD180),
          background: Color(0xFF0A1C3A),
          surface: Color(0xFF1E3050),
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onBackground: Colors.white,
          onSurface: Colors.white,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme.copyWith(
            titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            bodyLarge: GoogleFonts.roboto(fontSize: 16),
            bodyMedium: GoogleFonts.roboto(fontSize: 14),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0A1C3A),
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFF3D00),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            padding: EdgeInsets.symmetric(vertical: 16),
            textStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFFFFD180),
            textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF1E3050),
          labelStyle: GoogleFonts.roboto(color: Color(0xFFFFD180)),
          hintStyle: GoogleFonts.roboto(
            color: Color(0xFFFFD180).withOpacity(0.7),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xFFFF3D00), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Color(0xFFFF3D00), width: 1),
          ),
        ),
        cardTheme: CardThemeData(
          color: Color(0xFF1E3050),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
          shadowColor: Colors.black.withOpacity(0.2),
        ),
        iconTheme: IconThemeData(color: Color(0xFFFFD180)),
        dividerColor: Color(0xFFFFD180),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case '/':
            page = SplashScreen();
            break;
          case '/onboarding':
            page = OnboardingScreen();
            break;
          case '/login':
            page = LoginPage();
            break;
          case '/sign_up':
            page = SignUpPage();
            break;
          case '/home':
            page = HomePage();
            break;
          case '/case_details':
            page = CaseDetailsPage();
            break;
          case '/community':
            page = CommunityPage();
            break;
          case '/insights':
            page = InsightsPage();
            break;
          case '/profile':
            page = ProfilePage();
            break;
          case '/report':
            page = ReportCrimePage();
            break;
          case '/ai_detective':
            page = AiDetectivePage();
            break;
          case '/recent_cases':
            page = RecentCasesPage();
            break;
          case '/terms':
            page = TermsPage();
            break;
          case '/privacy':
            page = PrivacyPage();
            break;
          case '/feedback':
            page = FeedbackPage();
            break;
          case '/admin':
            page = AdminPanelPage();
            break;
          case '/emergency':
            page = EmergencyPage();
            break;
          default:
            page = HomePage();
        }
        return PageRouteBuilder(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(
              scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              alignment: Alignment.bottomCenter,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        );
      },
    );
  }
}
