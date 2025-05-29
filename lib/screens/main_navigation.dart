import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/app_theme.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;

  const MainNavigation({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    final bool showFAB = location == '/home';

    return Scaffold(
      body: child,      floatingActionButton: showFAB
          ? Container(
              height: 65,
              width: 65,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppTheme.primaryGradient,
                boxShadow: AppTheme.buttonShadow,
              ),
              child: FloatingActionButton(
                onPressed: () {
                  context.push(
                    '/book/lend', // We'll create this route
                  );
                },
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 0,
        color: Colors.white,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryColor.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          height: 55, // Slightly reduced height
          child: BottomNavigationBar(
            currentIndex: _getCurrentIndex(context),
            onTap: (index) => _onItemTapped(context, index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,            selectedItemColor: AppTheme.primaryColor,
            unselectedItemColor: AppTheme.textMuted,
            elevation: 0,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books_outlined),
                activeIcon: Icon(Icons.library_books),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add, color: Colors.transparent),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people_outlined),
                activeIcon: Icon(Icons.people),
                label: 'Community',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outlined),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getCurrentIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    switch (location) {
      case '/home':
        return 0;
      case '/library':
        return 1;
      case '/community':
        return 3; // Updated index
      case '/profile':
        return 4; // Updated index
      default:
        return 0;
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    // Skip the center placeholder (index 2)
    if (index == 2) return;

    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/library');
        break;
      case 3: // Updated index
        context.go('/community');
        break;
      case 4: // Updated index
        context.go('/profile');
        break;
    }
  }
}
