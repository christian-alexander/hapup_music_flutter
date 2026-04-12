import 'package:flutter/material.dart';
import '../../services/music_service.dart';
class MusicForm extends StatefulWidget {
  final int? musicId;
  const MusicForm({super.key, this.musicId});

  @override
  State<MusicForm> createState() => _MusicFormState();
}

class _MusicFormState extends State<MusicForm> {
  String _title = '';
  String _singer = '';
  String? _genreId;
  bool _inputValid = true;
  // genres data 
  late Future _genres;

  @override
  void initState() {
    // saat perama kali, get musics
    super.initState();
    _genres = MusicService.getAllGenre();
  }

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  void _backAfterFill() {
    Navigator.pop(context, true);
  }

  void _saveChanges() async{
    if(_title != "" && _singer != "" && _genreId != null){
      setState(() {
        _inputValid = true;
      });
      await MusicService.createMusic(_title, _singer, int.parse(_genreId!));
      _backAfterFill();
    }else{
      _inputValid = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4c60da),
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: Color(0xFFffffff)
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          (widget.musicId == null)? "Tambah Musik" : "Ubah Musik",
          style: TextStyle(
            fontSize: 18,
            color: Color(0xFFffffff)
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _inputValid == false ?
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 82, 97),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: EdgeInsets.all(10),
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    const Icon(
                      // icons
                      Icons.error_outline,
                      color: Color.fromARGB(255, 255, 255, 255), 
                      size: 18
                    ),
                    // sizedbox cuma buat spasi
                    const SizedBox(width: 8),
                    // expanded perlu agar text auto kebawah jika tidak cukup
                    Expanded(
                      child: const Text(
                        "Harap isi semua isian!",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255)
                        ),
                      ), 
                    )
                    
                  ],
                )
              )
              : const SizedBox.shrink(),

              // inputan judul
              Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                height: 40,
                child: TextField(
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    labelText: "Judul Musik",
                    labelStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color.fromARGB(50, 0, 0, 0)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color.fromARGB(50, 0, 0, 0)),
                    ),
                  ),
                  onChanged: (value) => _title = value,
                ),
              ),
              
              // inputan penyanyi
              Container(
                margin: EdgeInsets.only(
                  bottom: 10,
                ),
                height: 40,
                child: TextField(
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 12,
                  ),
                  decoration: InputDecoration(
                    labelText: "Penyanyi",
                    labelStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color.fromARGB(50, 0, 0, 0)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Color.fromARGB(50, 0, 0, 0)),
                    ),
                  ),
                  onChanged: (value) => _singer = value,
                ),
              ),
              
              // selector genre 
              FutureBuilder(
                future: _genres,
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (asyncSnapshot.hasError) {
                    return Text("Error: ${asyncSnapshot.error}");
                  }

                  final data = asyncSnapshot.data ?? [];

                  if (data.isEmpty) {
                    return const Text("Genre tidak ditemukan");
                  }

                  return Container(
                    width: double.infinity,
                    height: 40,
                    margin: EdgeInsets.only(
                      bottom: 10
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 10), 
                    decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(50, 0, 0, 0)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _genreId,
                        hint: Text("Pilih genre"),
                        style: TextStyle(
                          fontSize: 14
                        ),
                       items: [
                          ...data.map((genre) => DropdownMenuItem(
                                value: genre['id'].toString(),
                                child: Text(
                                  capitalize(genre['name']),
                                  style: TextStyle(
                                    color: Colors.black
                                  ),
                                ),
                              ))
                        ],
                        onChanged: (value) {
                          setState(() {
                            _genreId = value;
                          });
                        },
                      ),
                    ) 
                  );
                }
              ),

              // button save 
              Container(
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
                  // on press save changes 
                  onPressed: _saveChanges,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.musicId != null?
                        Icon(
                          Icons.edit, 
                          size: 18, 
                          color: Colors.white
                        )
                        :
                        Icon(
                          Icons.add, 
                          size: 18, 
                          color: Colors.white
                        )
                      ,
                      SizedBox(width: 5),
                      Text(
                        widget.musicId != null ? "Ubah" : "Tambah"
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}