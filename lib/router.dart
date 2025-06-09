import 'package:go_router/go_router.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/sign_in_landing_screen.dart';
import 'screens/create_account_screen.dart';
import 'screens/apartment_details_screen.dart';
import 'screens/home_screen.dart';
import 'screens/library_screen.dart';
import 'screens/book_details_screen.dart';
import 'screens/community_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/main_navigation.dart';
import 'screens/lend_book_screen.dart';
import 'screens/borrowed_book_detail_screen.dart';
import 'screens/lending_book_detail_screen.dart';
import 'screens/all_books_screen.dart';
import 'screens/book_detail_screen.dart';
import 'screens/search_results_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/sign-in',
        name: 'sign-in',
        builder: (context, state) => const SignInLandingScreen(),
      ),
      GoRoute(
        path: '/create-account',
        name: 'create-account',
        builder: (context, state) => const CreateAccountScreen(),
      ),
      GoRoute(
        path: '/apartment-details',
        name: 'apartment-details',
        builder: (context, state) => const ApartmentDetailsScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: '/book/lend',
        name: 'lend',
        builder: (context, state) => const LendBookScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainNavigation(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/library',
            name: 'library',
            builder: (context, state) => const LibraryScreen(),
          ),
          GoRoute(
            path: '/community',
            name: 'community',
            builder: (context, state) => const CommunityScreen(),
          ),
          GoRoute(
            path: '/profile',
            name: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/book/:id',
        name: 'book-details',
        builder: (context, state) {
          final bookId = state.pathParameters['id']!;
          return BookDetailsScreen(bookId: bookId);
        },
      ),      GoRoute(
        path: '/book/lend',
        builder: (context, state) => const LendBookScreen(),
      ),
      GoRoute(
        path: '/book/borrowed/:title',
        name: 'borrowed-book-detail',
        builder: (context, state) {
          final bookData = state.extra as Map<String, dynamic>;
          return BorrowedBookDetailScreen(book: bookData);
        },
      ),      GoRoute(
        path: '/book/lending/:title',
        name: 'lending-book-detail',
        builder: (context, state) {
          final bookData = state.extra as Map<String, dynamic>;
          return LendingBookDetailScreen(book: bookData);
        },
      ),      GoRoute(
        path: '/books/all/:category',
        name: 'all-books',
        builder: (context, state) {
          final category = state.pathParameters['category']!;
          return AllBooksScreen(category: category);
        },
      ),      GoRoute(
        path: '/search/:query',
        name: 'search-results',
        builder: (context, state) {
          final query = state.pathParameters['query']!;
          return SearchResultsScreen(query: Uri.decodeComponent(query));
        },
      ),
      GoRoute(
        path: '/book/detail/:title/:author',
        name: 'book-detail',
        builder: (context, state) {
          final title = state.pathParameters['title']!;
          final author = state.pathParameters['author']!;
          return BookDetailScreen(
            title: Uri.decodeComponent(title), 
            author: Uri.decodeComponent(author),
          );
        },
      ),
    ],
  );
}
