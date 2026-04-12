import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MusicService {

  static late Database _db;

  static Future<void> initDB() async {
    // func init db, penting, untuk init db sebelum melakukan semua query
    // dipanggil dari splash page utama
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'happy_music.db');

    _db = await openDatabase(
      path,
      version: 1,
      // ketika init, buat tabel dlu
      onCreate: (db, version) async {

        // genre table
        await db.execute('''
          create table 
            genre (
              id integer primary key autoincrement, 
              name text not null,
              badge_color text not null
            )
        ''');

        // music table, on delete ca
        await db.execute('''
          create table 
            music (
              id integer primary key autoincrement,
              title text not null, 
              singer text, 
              genre_id integer not null
            )
        ''');

        // seed table genre (3 dummy genre)
        await db.rawInsert('insert into genre (name, badge_color) values ("pop","#8D6E63"),("rock", "#78909C"),("jazz", "#9E9D24")');

        // seed table music
        await db.rawInsert('''
          insert into music
            (title,singer, genre_id)
          values
            ("Ordinary World", "Duran Duran", 2),
            ("Forever Young", "Aphaville", 1),
            ("Cant Help Falling In Love", "Elvis Presley", 1),
            ("What A Beautiful World", "Louis Armstrong", 3)
        ''');         
      },
    );
  }

  // get genre
  static Future<List<Map<String, dynamic>>> getAllGenre() async {
    return await _db.rawQuery('select * from genre');
  }

  // crud musics
  // get (+ joined with genre) dan filters serta orders  
  static Future<List<Map<String, dynamic>>> getMusicWithGenre(int orderType, int? genreId, String? searchQuery) async {
    // order type 1 by nama lagu asc,
    // order type 2 by nama penyanyi asc
    // genre id if null semua genre 
    // searchQuery where like

    // filters
    String filters = '';
    List<dynamic> params = [];
    if(genreId != null || searchQuery != null){
      filters = ' where ';
      if(genreId != null){
        filters += ' genre_id = ?';
        params.add(genreId);
      }
      if(searchQuery != null){
        if(genreId != null){
          filters += ' and';
        }
        filters += ' (a.title like ? or a.singer like ? or b.name like ?)';
        params.add('%$searchQuery%');
        params.add('%$searchQuery%');
        params.add('%$searchQuery%');
      }
    }

    // str untuk orderby
    String strOrderBy = '';
    switch(orderType){
      case 1: 
        strOrderBy = ' order by a.title asc';
        break;
      case 2: 
        strOrderBy = ' order by a.singer asc';
        break;
      default: 
        break;
    }

    return await _db.rawQuery('''
      select 
        a.id,
        a.title,
        a.singer,
        a.genre_id,
        b.name AS genre,
        b.badge_color
      from 
        music as a
        left join genre as b
          on b.id = a.genre_id
      $filters
      $strOrderBy
    ''', params);
  }

  // create
  static Future<int> createMusic(String title, String singer, int genreId) async {;
    return await _db.rawInsert('insert into music (title, singer, genre_id) values (?,?,?)', [title, singer, genreId]);
  }

  // update
  static Future<int> updateMusic(int id, String title, String singer, int genreId) async {
    return await _db.rawUpdate('update music set title = ?, singer = ?, genre_id = ? where id = ?', [title, singer, genreId, id]);
  }

  // delete
  static Future<int> deleteMusic(int id) async {
    return await _db.rawDelete('delete from music where id = ?', [id]);
  }
}