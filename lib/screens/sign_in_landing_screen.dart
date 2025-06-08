import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignInLandingScreen extends StatelessWidget {
  const SignInLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Positioned(
                  left: 50,
                  top: 252,
                  child: const Text(
                    'Sign in your account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26.72,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 4.18,
                      letterSpacing: 0.53,
                    ),
                  ),
                ),
                Positioned(
                  left: 51,
                  top: 346.84,
                  child: Container(
                    width: 288,
                    height: 42,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFAFAFA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'ex: jon.smith@email.com',
                        hintStyle: TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 138,
                  top: 572.84,
                  child: const Text(
                    'or sign in with',
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 3.12,
                      letterSpacing: 0.32,
                    ),
                  ),
                ),
                Positioned(
                  left: 63,
                  top: 698.84,
                  child: const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      color: Color(0xFF888888),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 3.12,
                      letterSpacing: 0.32,
                    ),
                  ),
                ),                Positioned(
                  left: 264,
                  top: 698.84,
                  child: GestureDetector(
                    onTap: () {
                      context.push('/create-account');
                    },
                    child: const Text(
                      'SIGN UP',
                      style: TextStyle(
                        color: Color(0xFF00B140),
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 3.12,
                        letterSpacing: 0.32,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 51,
                  top: 425.84,
                  child: Container(
                    width: 288,
                    height: 42,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFAFAFA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '*********',
                        hintStyle: TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 51,
                  top: 504.84,
                  child: GestureDetector(
                    onTap: () {
                      // Handle sign in
                      context.go('/home');
                    },
                    child: Container(
                      width: 288,
                      height: 42,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF00B140),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 51,
                  top: 322.84,
                  child: const Text(
                    'Email',
                    style: TextStyle(
                      color: Color(0xFF6E6E6E),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 3.12,
                      letterSpacing: 0.32,
                    ),
                  ),
                ),
                Positioned(
                  left: 51,
                  top: 401.84,
                  child: const Text(
                    'Password',
                    style: TextStyle(
                      color: Color(0xFF6E6E6E),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 3.12,
                      letterSpacing: 0.32,
                    ),
                  ),
                ),
                // Social login buttons
                Positioned(
                  left: 51,
                  top: 613.84,
                  child: Container(
                    width: 86,
                    height: 42,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF4F4F4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Icon(Icons.g_mobiledata, size: 24),
                  ),
                ),
                Positioned(
                  left: 152,
                  top: 613.84,
                  child: Container(
                    width: 86,
                    height: 42,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF4F4F4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Icon(Icons.facebook, size: 24),
                  ),
                ),
                Positioned(
                  left: 253,
                  top: 613.84,
                  child: Container(
                    width: 86,
                    height: 42,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF4F4F4),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Icon(Icons.apple, size: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
