
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_media_mobile/api/api_client.dart';
import 'package:social_media_mobile/main.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
  }

  void _submitForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        await loginUser(_email, _password);
        Navigator.pushNamed(context, "/home");
      }
    } on DioException catch (e) {
      if(e.response?.statusCode == 401) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid email or password")),
          );
      } else {
        print("Failed to login: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Something went wrong, please try again."),
          ),
        );
      }
    }
  }

  Future<bool> loginUser(String email, String password) async {
    final response = await api.call(
      "POST",
      "/api/auth/login",
      data: {'email': email, 'password': password}
    );

    return response.statusCode == 200;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Image.asset('assets/images/login-bg.jpg', fit: BoxFit.cover),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const Text(
                    "Blogify",
                    style: TextStyle(
                      fontSize: 45,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'FugazOne',
                    ),
                  ),
                  const SizedBox(height: 30),

                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            initialValue: "tjiungbin10@gmail.com",
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              prefixIcon: Icon(Icons.email),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(18),
                            ),
                            onSaved: (value) => _email = value!,
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? 'Enter email'
                                        : null,
                          ),
                        ),
                        const SizedBox(height: 14),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            initialValue: "binbin0219",
                            decoration: InputDecoration(
                              hintText: "Password",
                              border: InputBorder.none,
                              prefixIcon: Icon(Icons.lock),
                              contentPadding: EdgeInsets.all(18),
                            ),
                            obscureText: true,
                            onSaved: (value) => _password = value!,
                            validator:
                                (value) =>
                                    value == null || value.isEmpty
                                        ? 'Enter email'
                                        : null,
                          ),
                        ),
                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {},
                              child: const Text("Sign Up"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
