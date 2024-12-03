import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class UserProfile {
  int? id;
  String? teamImage;
  String? playerImage;

  UserProfile({this.id, this.teamImage, this.playerImage});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'teamImage': teamImage,
      'playerImage': playerImage,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      teamImage: map['teamImage'],
      playerImage: map['playerImage'],
    );
  }

  get name => null;
}

class DBHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_profile.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE userProfile(id INTEGER PRIMARY KEY, teamImage TEXT, playerImage TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> saveUserProfile(UserProfile profile) async {
    final db = await database;
    await db.insert(
      'userProfile',
      profile.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<UserProfile?> getUserProfile() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('userProfile');
    if (maps.isNotEmpty) {
      return UserProfile.fromMap(maps.first);
    }
    return null;
  }
}
