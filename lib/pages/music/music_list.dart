import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../login.dart';
class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {

  String? _filterGenre = 'all'; 

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
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            // searchbox 
            Container(
              width: double.infinity,
              height: 40,
              child: TextField(
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    size: 18,
                    color: Color(0xFF000000)
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color.fromARGB(50, 0, 0, 0)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color.fromARGB(50, 0, 0, 0)),
                  ),
                  hintText: 'Cari...',
                  hintStyle: TextStyle(color: Color.fromARGB(100, 0, 0, 0)),
                ),
              ),
            ),
            
            // dropdown genre
            Container(
              width: double.infinity,
              height: 40,
              margin: EdgeInsets.only(
                top: 10, 
                bottom: 10
              ),
              padding: EdgeInsets.symmetric(horizontal: 10), 
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(50, 0, 0, 0)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  // icon
                  Icon(
                    Icons.filter_alt_outlined, 
                    size: 18,
                    color: Color(0xFF000000)
                  ),

                  SizedBox(width:10),

                  // dropdown 
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _filterGenre,
                        hint: Text("Pilih genre"),
                        style: TextStyle(
                          fontSize: 14
                        ),
                        items: [
                          DropdownMenuItem(value: "all", child: Text("Semua Genre")),
                          DropdownMenuItem(value: "rock", child: Text("Rock")),
                          DropdownMenuItem(value: "pop", child: Text("Pop")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _filterGenre = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ) 
            ),

            // Info 
            Container(
              height:30, 
              margin: EdgeInsets.only(
                bottom: 10
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Info lagu 
                  Container(
                    width: 100, 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '20 Musik',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0x88000000)
                          )
                        ),
                      ],
                    )
                  ),

                  const Spacer(),

                  Container(
                    child: GestureDetector(
                      onTap: () => Text('testus'),
                      child: Container(
                        padding:  EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFFffffff),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color.fromARGB(50, 0, 0, 0)),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.sort_rounded,
                              color: Color(0xFF000000), 
                              size: 16
                            ),
                            
                            SizedBox(width: 5),
                            
                            Text(
                              "testuss",
                              style: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ),

            // music list
            Expanded(
              child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    elevation: 3,
                    child: ListTile(
                      leading: Icon(Icons.dashboard),
                      title: Text("Card $index"),
                      subtitle: Text("Deskripsi card $index"),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}