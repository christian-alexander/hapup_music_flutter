import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../services/music_service.dart';
import '../login.dart';
import 'music_form.dart';
class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {

  String? _filterGenre = 'all'; 
  // main data musics, dapat dari music service
  late Future _musics;

  @override
  void initState() {
    // saat perama kali, get musics
    super.initState();
    _musics = MusicService.getMusicWithGenre(1, null, null);
  }

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
          'Apakah Anda yakin ingin keluar?',
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
                borderRadius: BorderRadius.circular(10)
              ),
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

  // push form page for add action
  void _add() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const MusicForm(),
      ),
    );
  }

  // push form page for edit action
  void _edit(int musicId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MusicForm(musicId: musicId),
      ),
    );
  }

  // bottom sheet untuk pilihan sort 
  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFFffffff),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(100, 0, 0, 0),
                    borderRadius: BorderRadius.circular(2)),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Urutkan berdasarkan',
              style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            RadioGroup(
              groupValue: "title_asc",
              onChanged: (value) {
                // setState(() => selectedValue = value!);
              },
              child: Column(
                children: [
                  RadioListTile(
                    value: "title_asc",
                    title: Text("Judul (a-Z)"),
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: EdgeInsets.zero,
                  ),
                  RadioListTile(
                    value: "singer_asc",
                    title: Text("Nama Penyanyi (a-Z)"),
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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

                  const SizedBox(width:10),

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
                  // Info musik
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

                  GestureDetector(
                    onTap: () => _showSortSheet(),
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
                          
                          const SizedBox(width: 5),
                          
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
                ],
              )
            ),

            // music list
            Expanded(
              child: FutureBuilder(
                future: _musics,
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (asyncSnapshot.hasError) {
                    return Center(child: Text("Error: ${asyncSnapshot.error}"));
                  }

                  final data = asyncSnapshot.data ?? [];

                  if (data.isEmpty) {
                    return const Center(child: Text("Belum ada data"));
                  }

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final music = data[index];
                      return Card(
                        margin: EdgeInsets.all(10),
                        elevation: 3,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.music_note_outlined),
                              title: Text(music['title']),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(music['singer']),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Color(int.parse("0xFF${music['badge_color']}")),
                                      // color: Color(0xFF78909C),
                                      // color: Color(0xFF9E9D24),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text(
                                      music['genre'],
                                      style: TextStyle(
                                        color: Color(0xFFffffff),
                                        fontSize: 12
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            // buttons
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Color(0x11000000),
                                    width:1
                                  )
                                )
                              ),
                              child: Row(
                                children: [
                  
                                  // edit
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            color: Color(0x11000000),
                                            width: 1
                                          )
                                        )
                                      ),
                                      child: TextButton(
                                        onPressed: () => _edit(1), 
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 30,
                                              child: Icon(
                                                Icons.edit,
                                                size: 18, 
                                                color: Color(0xFF1166ff)
                                              ),
                                            ),
                                            const SizedBox(width:1),
                                            const Text(
                                              'Ubah',
                                              style: TextStyle(
                                                color: Color(0xFF1166ff),
                                                fontSize: 14
                                              ),
                                            )
                                          ],
                                        )
                                      ),
                                    ),
                                  ),
                                  
                                  // delete
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          right: BorderSide(
                                            color: Color(0x11000000),
                                            width: 1
                                          )
                                        )
                                      ),
                                      child: TextButton(
                                        onPressed: () => {}, 
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 30,
                                              child: Icon(
                                                Icons.delete,
                                                size: 18, 
                                                color: Color.fromARGB(255, 255, 82, 97)
                                              ),
                                            ),
                                            const SizedBox(width:1),
                                            const Text(
                                              'Hapus',
                                              style: TextStyle(
                                                color: Color.fromARGB(255, 255, 82, 97),
                                                fontSize: 14
                                              ),
                                            )
                                          ],
                                        )
                                      ),
                                    ),
                                  ),
                                  
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height:45,
        child: FloatingActionButton.extended(
          onPressed: () => _add(),
          backgroundColor: Color(0xFF6777EF),
          foregroundColor: Color(0xFFffffff),
          icon: Icon(Icons.add),
          label: Text("Tambah"),
        ),
      ),
    );
  }
}