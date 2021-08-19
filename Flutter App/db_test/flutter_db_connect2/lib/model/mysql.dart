import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host = '13.209.100.19',
      user = 'kym',
      password = 'kim',
      db = 'db';
  static int port = 3306;

  Mysql();

  Future<MySqlConnection> getConnection() async {
    var settings = new ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db);
    return await MySqlConnection.connect(settings);
  }
}
