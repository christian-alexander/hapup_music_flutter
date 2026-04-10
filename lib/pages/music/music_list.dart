import 'package:flutter/material.dart';
class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("MusicList")
      ),
    );
  }
}