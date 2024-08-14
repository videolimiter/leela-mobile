import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:leela_mobile/design/colors.dart';
import 'package:leela_mobile/design/dimensions.dart';
import 'package:leela_mobile/src/config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final dio = Dio();
  void _submit() async {
    final isValidEmail = _emailController.text.isNotEmpty &&
        EmailValidator.validate(_emailController.text);
    final isValidPassword = _passwordController.text.isNotEmpty &&
        _passwordController.text.length > 5;
    if (!isValidEmail || !isValidPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Введены не корректные данные')));
      return;
    }

    final loginData = {
      "email": _emailController.text,
      "password": _passwordController.text,
    };
    print(LOGIN_URL);
    try {
      final response = await dio.post(
        LOGIN_URL,
        data: loginData,
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Вы успешно вошли')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Неверный пароль или email')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Container(
      padding: const EdgeInsets.all(paddingDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Login Screen',
            style: TextStyle(
                fontSize: fontHeadingSize,
                fontWeight: FontWeight.bold,
                color: thirdColor),
          ),
          Form(
              autovalidateMode: AutovalidateMode.always,
              child: Container(
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 20),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: 'Email',
                            hintText: 'Email'),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          if (!EmailValidator.validate(value)) {
                            return 'Not a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        validator: (String? value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 6) {
                            return 'Password is required and must be 6 characters long.';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: Icon(Icons.visibility_outlined),
                            labelText: 'Password',
                            hintText: 'Password'),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: const Text('Forgot password?'))),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () => _submit(),
                              child: const Text('Login')))
                    ],
                  )))
        ],
      ),
    ))));
  }
}
