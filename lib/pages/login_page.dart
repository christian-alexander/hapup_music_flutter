import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(50, 58, 59, 69),
                blurRadius: 10
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(
                  bottom:15
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 16, // ukuran dalam logical pixels
                  ),
                ),
              ),
              // Username field
              Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                height: 30,
                child: TextField(
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color.fromARGB(50, 0, 0, 0)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color.fromARGB(50, 0, 0, 0)),
                    ),
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                height: 30,
                child: TextField(
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color.fromARGB(50, 0, 0, 0)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color.fromARGB(50, 0, 0, 0)),
                    ),
                    hintText: 'Password',
                    hintStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: 10
                ),
                height: 30,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6777EF),
                    foregroundColor: Color.fromARGB(255, 255, 255, 255),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    //
                  },
                  child: Text('Login'),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}