import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../login.dart';
class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {

  Future<void> _handleLogout() async {

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFFffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        title: const Text(
          'Keluar',
          style: TextStyle(
            color: Color(0xFF000000), 
            fontWeight: FontWeight.w700
          )
        ),
        content: const Text(
          'Apakah kamu yakin ingin keluar?',
          style: TextStyle(
            color: Color(0xFF888888)
          )
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal',
                style: TextStyle(color: Color(0xFF888888))),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6777EF),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Keluar',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if(confirmed == true){
      await AuthService.processLogout();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const Login(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4c60da),
        title: const Text(
          "HappyMusic",
          style: TextStyle(
            color: Color(0xFFffffff)
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              size: 18,
              color: Color(0xFFffffff)
            ),
            onPressed: () => _handleLogout(),
          )
        ],
      ),
      body: Container(
        child: Text(
          "MusicList"
        )
      ),
    );
  }
}