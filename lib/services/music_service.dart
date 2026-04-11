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
      // pengint: configure agar sqlite aktifkan foreign key (relasi genre dan music)
      onConfigure: (db) async {
        await db.execute('pragma foreign_keys = on') ;
      },
      // ketika init, buat tabel dlu
      onCreate: (db, version) async {

        // genre table
        await db.execute('''
          create table 
            genre (
              id integer, 
              name text not null
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
        await db.rawInsert('insert into genre (name) values ("pop"),("rock"),("jazz")');

        // seed table music
        await db.rawInsert('''
          insert into music
            (title,singer, genre_id)
          values
            ("Ordinary World", "Duran Duran", 1),
            ("Forever Young", "Aphaville", 2),
            ("What A Beautiful World", "Louis Armstrong", 3)
        ''');         
      },
    );
  }

  // crud musics
  // get (+ joined with genre) dan filters serta orders  
  static Future<List<Map<String, dynamic>>> getMusicWithGenre( Map<String, dynamic> filters, String orderKey, String orderDirection) async {

    // wheres and order by
    String wheres = ''; 
    String strOrderBy = 'order by $orderKey $orderDirection';

    // arr kosong conditions dan arguments 
    List<String> conditions = [];
    List<dynamic> args = [];

    // add to arr wheres
    filters.forEach((key, value) {
      conditions.add('$key = ?');
      args.add(value);
    });

    if(conditions.isNotEmpty){
      wheres =  'where ${conditions.join(' and ')}';
    }

    return await _db.rawQuery('''
      select 
        a.id,
        a.title,
        a.singer,
        a.genre_id,
        b.name AS genre
      from 
        music as a
        left join genre as b
          on b.id = a.genre_id
      $wheres
      $strOrderBy
    ''', args);
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