import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  bool _acceptTerms = false;

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
                // Back button with H icon
                Positioned(
                  left: 315,
                  top: 67,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          width: 0.93,
                          color: Color(0xFF34A751),
                        ),
                        borderRadius: BorderRadius.circular(6.41),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'H',
                        style: TextStyle(
                          color: Color(0xFF34A751),
                          fontSize: 16,
                          fontFamily: 'Caveat Brush',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 50,
                  top: 154,
                  child: const Text(
                    'Create your account',
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
                // Name field
                Positioned(
                  left: 51,
                  top: 214,
                  child: const Text(
                    'Name',
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
                  top: 238,
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
                        hintText: 'ex: jon smith',
                        hintStyle: TextStyle(
                          color: Color(0xFF888888),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      ),
                    ),
                  ),
                ),
                // Email field
                Positioned(
                  left: 51,
                  top: 297,
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
                  top: 321,
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
                // Password field
                Positioned(
                  left: 51,
                  top: 380,
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
                Positioned(
                  left: 51,
                  top: 404,
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
                // Confirm password field
                Positioned(
                  left: 51,
                  top: 463,
                  child: const Text(
                    'Confirm password',
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
                  top: 487,
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
                // Terms and conditions checkbox
                Positioned(
                  left: 53,
                  top: 547,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _acceptTerms = !_acceptTerms;
                      });
                    },
                    child: Container(
                      width: 13,
                      height: 13,
                      decoration: ShapeDecoration(
                        color: _acceptTerms ? const Color(0xFF00B140) : Colors.transparent,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFF00B140),
                          ),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                      child: _acceptTerms
                          ? const Icon(
                              Icons.check,
                              size: 10,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                ),
                Positioned(
                  left: 75,
                  top: 550,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                          text: 'I understood the ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 4.15,
                          ),
                        ),
                        TextSpan(
                          text: 'terms & policy',
                          style: const TextStyle(
                            color: Color(0xFF00B140),
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 4.15,
                          ),
                          // You can add onTap here to open terms and policy
                        ),
                        const TextSpan(
                          text: '.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 4.15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Sign up button
                Positioned(
                  left: 51,
                  top: 578,
                  child: GestureDetector(
                    onTap: () {
                      if (_acceptTerms) {
                        // Navigate to apartment details
                        context.push('/apartment-details');
                      } else {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please accept the terms and policy'),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 288,
                      height: 42,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: _acceptTerms ? const Color(0xFF00B140) : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'SIGN UP',
                          textAlign: TextAlign.center,
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
                  left: 135,
                  top: 646,
                  child: const Text(
                    'or sign up with',
                    textAlign: TextAlign.center,
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
                // Social login buttons
                Positioned(
                  left: 51,
                  top: 680,
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
                  top: 680,
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
                  top: 680,
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
                Positioned(
                  left: 88,
                  top: 748,
                  child: const Text(
                    'Have an account? ',
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
                  left: 243,
                  top: 748,
                  child: GestureDetector(
                    onTap: () {
                      context.pop();
                    },
                    child: const Text(
                      'SIGN IN',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
