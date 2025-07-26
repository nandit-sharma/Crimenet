import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedLayout extends StatefulWidget {
  final Widget child;
  final int currentIndex;
  final String title;
  final bool showBackButton;
  final List<Widget>? actions;

  const SharedLayout({
    super.key,
    required this.child,
    required this.currentIndex,
    required this.title,
    this.showBackButton = false,
    this.actions,
  });

  @override
  State<SharedLayout> createState() => _SharedLayoutState();
}

class _SharedLayoutState extends State<SharedLayout>
    with TickerProviderStateMixin {
  late AnimationController _navController;
  late Animation<double> _navAnimation;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _navController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _navAnimation = CurvedAnimation(
      parent: _navController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _navController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: widget.showBackButton
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              )
            : IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
        title: Text(
          widget.title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Color(0xFFFFC55A)),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
          ...?widget.actions,
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF101A30), Color(0xFF1E3050)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: EdgeInsets.only(top: 40),
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xFFFC4100),
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
                            color: Color(0xFFFFC55A),
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
              Divider(
                color: Color(0xFFFFC55A),
                thickness: 1,
                indent: 16,
                endIndent: 16,
              ),
              _drawerMenuItem(context, Icons.insights, 'Insights', '/insights'),
              _drawerMenuItem(context, Icons.feedback, 'Feedback', '/feedback'),
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
      body: widget.child,
      bottomNavigationBar: widget.currentIndex >= 0
          ? Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1E3050), Color(0xFF101A30)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                selectedItemColor: Color(0xFFFC4100),
                unselectedItemColor: Colors.white.withOpacity(0.7),
                currentIndex: widget.currentIndex,
                elevation: 0,
                selectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                unselectedLabelStyle: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
                onTap: (index) {
                  if (index != widget.currentIndex) {
                    _navController.forward().then((_) {
                      _navController.reverse();
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
                    });
                  }
                },
                items: [
                  _buildNavItem(Icons.home, 'Home'),
                  _buildNavItem(Icons.history, 'Recent Cases'),
                  _buildNavItem(Icons.group, 'Community'),
                  _buildNavItem(Icons.psychology, 'AI'),
                ],
              ),
            )
          : null,
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData icon, String label) {
    return BottomNavigationBarItem(
      icon: AnimatedBuilder(
        animation: _navAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: 1.0 + (_navAnimation.value * 0.1),
            child: Icon(icon),
          );
        },
      ),
      label: label,
    );
  }

  Widget _drawerMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String route,
  ) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          splashColor: Color(0xFFFC4100).withOpacity(0.3),
          highlightColor: Color(0xFFFFC55A).withOpacity(0.1),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, route);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.transparent, width: 1),
            ),
            child: Row(
              children: [
                Icon(icon, color: Color(0xFFFFC55A), size: 24),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Color(0xFFFC4100),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
