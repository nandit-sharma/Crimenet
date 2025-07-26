import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        scaffoldBackgroundColor: Color(0xFF101A30),
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFFC4100),
          secondary: Color(0xFFFFC55A),
          background: Color(0xFF101A30),
          surface: Color(0xFF1E3050),
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onBackground: Colors.white,
          onSurface: Colors.white,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme.copyWith(
            titleLarge: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
            bodyLarge: GoogleFonts.roboto(fontSize: 17),
            bodyMedium: GoogleFonts.roboto(fontSize: 15),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF101A30),
          foregroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFC4100),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            elevation: 6,
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 32),
            textStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
            shadowColor: Color(0xFFFFC55A).withOpacity(0.3),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Color(0xFFFFC55A),
            textStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF1E3050),
          labelStyle: GoogleFonts.roboto(color: Color(0xFFFFC55A)),
          hintStyle: GoogleFonts.roboto(
            color: Color(0xFFFFC55A).withOpacity(0.7),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Color(0xFFFC4100), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Color(0xFFFC4100), width: 1),
          ),
        ),
        cardTheme: CardThemeData(
          color: Color(0xFF1E3050),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 8,
          shadowColor: Color(0xFFFC4100).withOpacity(0.15),
        ),
        iconTheme: IconThemeData(color: Color(0xFFFFC55A)),
        dividerColor: Color(0xFFFFC55A),
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
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: FadeTransition(opacity: animation, child: child),
            );
          },
        );
      },
    );
  }
}
