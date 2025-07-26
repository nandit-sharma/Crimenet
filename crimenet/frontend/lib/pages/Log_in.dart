import '../widgets/modern_button.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      String phone = phoneController.text;
      String password = passwordController.text;
    }
  }

  void _forgotPassword() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF101A30), Color(0xFF1E3050)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
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
                      child: Icon(Icons.lock, size: 48, color: Colors.white),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFC55A),
                      ),
                    ),
                    SizedBox(height: 32),
                    _styledTextField(
                      phoneController,
                      'Phone Number',
                      Icons.phone,
                      isNumber: true,
                    ),
                    SizedBox(height: 20),
                    _styledTextField(
                      passwordController,
                      'Password',
                      Icons.lock,
                      isPassword: true,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _forgotPassword,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Color(0xFFFC4100)),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    ModernButton(
                      text: 'Login',
                      icon: Icons.login,
                      onPressed: _submit,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _styledTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool isNumber = false,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ? _obscurePassword : false,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFFFC4100)),
        filled: true,
        fillColor: Color(0xFF2C4E80),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Color(0xFFFC4100)),
        ),
        labelStyle: TextStyle(color: Color(0xFFFFC55A)),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Color(0xFFFC4100),
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              )
            : null,
      ),
      style: TextStyle(color: Colors.white),
      keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
      validator: (value) {
        if (label == 'Phone Number') {
          if (value == null || value.isEmpty || value.length < 10) {
            return 'Enter a valid phone number';
          }
        }
        if (label == 'Password') {
          if (value == null || value.length < 6) {
            return 'Password must be at least 6 characters';
          }
        }
        return null;
      },
    );
  }
}
