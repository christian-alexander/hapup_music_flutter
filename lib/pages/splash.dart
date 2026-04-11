import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'music/music_list.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();

  }

  Future<void> _checkLoggedIn() async {
    final isLogged = await AuthService.isLogged();
    print(isLogged);
    if(isLogged){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const MusicList(),
        ),
      );
    }else{
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const Login(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xFF6777EF),
          strokeWidth: 3,
        ),
      ),
    );
  }
}