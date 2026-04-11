import 'package:flutter/material.dart';
class MusicForm extends StatefulWidget {
  final int? musicId;
  const MusicForm({super.key, this.musicId});

  @override
  State<MusicForm> createState() => _MusicFormState();
}

class _MusicFormState extends State<MusicForm> {

  void _back() {
    Navigator.pop(context, "data");
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
          onPressed: () => _back(),
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
                ),
              ),
              
              // selector genre 
              Container(
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
                    hint: Text("Pilih genre"),
                    style: TextStyle(
                      fontSize: 14
                    ),
                    items: [
                      DropdownMenuItem(value: "rock", child: Text("Rock")),
                      DropdownMenuItem(value: "pop", child: Text("Pop")),
                    ],
                    onChanged: (value) {
                      // setState(() {
                      //   _filterGenre = value;
                      // });
                    },
                  ),
                ) 
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
                  // on press try login untuk cek pw 
                  onPressed: () {},
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