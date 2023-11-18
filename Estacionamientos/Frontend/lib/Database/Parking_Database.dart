import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:frontend_app/screens/admin/models/parking.dart';

class ParkingDatabase {
  static final ParkingDatabase instance = ParkingDatabase._init();
  static Database? _database;
  ParkingDatabase._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('Parking.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath =
        await getDatabasesPath(); //getApplicationDocumentsDirectory()
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final idrefType = 'INTEGER PRIMARY KEY';
    final textType = 'TEXT NOT NULL';
    final textTypeN = 'TEXT';
    final integerType = 'INTEGER NOT NULL';
    final integerTypeN = 'INTEGER';
    final boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
        CREATE TABLE $tableUser (
        ${UserField.userid} $idType,
        ${UserField.name} $textType,
        ${UserField.mail} $textTypeN,
        ${UserField.password} $textType,
        ${UserField.number} $integerTypeN,
        ${UserField.tipo} $integerTypeN
        )
        ''');
    await db.execute('''
        CREATE TABLE $tableParking (
        ${ParkingField.parkingid} $idType,
        ${ParkingField.location} $textType,
        ${ParkingField.state} $boolType,
        ${ParkingField.type} $textType
        )
        ''');
    await db.execute('''
        CREATE TABLE $tableDisability (
        ${DisabilityField.userid} $idrefType,
        ${DisabilityField.typeOfDisability} $textType,
        FOREIGN KEY(${DisabilityField.userid}) REFERENCES $tableUser(${UserField.userid})
        )
        ''');
    await db.execute('''
        CREATE TABLE $tableReserve (
        ${ReserveField.userid} $integerType,
        ${ReserveField.parkingid} $integerType,
        ${ReserveField.admPos} $textTypeN,
        FOREIGN KEY(${ReserveField.userid}) REFERENCES $tableUser(${UserField.userid}),
        FOREIGN KEY(${ReserveField.parkingid}) REFERENCES $tableParking(${ParkingField.parkingid}),
        PRIMARY KEY(${ReserveField.userid},${ReserveField.parkingid})
        )
        ''');
    await db.execute('''
        CREATE TABLE $tableParked (
        ${ParkedField.userid} $integerTypeN,
        ${ParkedField.parkingid} $integerType,
        FOREIGN KEY(${ParkedField.userid}) REFERENCES $tableUser(${UserField.userid}),
        FOREIGN KEY(${ParkedField.parkingid}) REFERENCES $tableParking(${ParkingField.parkingid})
        PRIMARY KEY(${ReserveField.parkingid})
        )
        ''');
        await db.execute('''
        CREATE TABLE $tableAdmin (
        ${AdminField.userid} $idrefType,
        FOREIGN KEY(${AdminField.userid}) REFERENCES $tableUser(${UserField.userid})
        )
        ''');
    }
    Future<User> createUser(User user) async{
        final db = await instance.database;
        final id = await db.insert(tableUser, user.toJson());
        return user.copy(userid: id);
    }
    Future<Parking> createParking(Parking p) async{
        final db = await instance.database;
        final id = await db.insert(tableParking, p.toJson());
        return p.copy(parkingid: id);
    }
    Future<Disability> createDisability(Disability d) async{
        final db = await instance.database;
        final id = await db.insert(tableDisability, d.toJson());
        return d.copy(userid: id);
    }
    Future<Reserve> createReserve(Reserve r) async{ /////////////////////////////
        final db = await instance.database;
        final id = await db.insert(tableReserve, r.toJson());
        return r.copy(parkingid: id);
    }
    Future<Parked> createParked(Parked p) async{ 
        final db = await instance.database;
        final id = await db.insert(tableParked, p.toJson());
        return p.copy(parkingid: id);
    }
    Future<Admin> createAdmin(Admin p) async{ 
        final db = await instance.database;
        final id = await db.insert(tableAdmin, p.toJson());
        return p.copy(userid: id);
    }
    Future<User> readUser(int userid) async{
        final db = await instance.database;
        final maps = await db.query(
            tableUser,
            columns: UserField.values,
            where: '${UserField.userid} = ?',
            whereArgs: [userid],
        );
        if(maps.isNotEmpty){
            return User.fromJson(maps.first);
        }else{
            throw Exception('ID $userid not found');
        }
    }
    Future<Parking> readParking(int parkingid) async{
        final db = await instance.database;
        final maps = await db.query(
            tableParking,
            columns: ParkingField.values,
            where: '${ParkingField.parkingid} = ?',
            whereArgs: [parkingid],
        );
        if(maps.isNotEmpty){
            return Parking.fromJson(maps.first);
        }else{
            throw Exception('ID $parkingid not found');
        }
    }
    Future<Disability> readDisability(int userid) async{
        final db = await instance.database;
        final maps = await db.query(
            tableDisability,
            columns: DisabilityField.values,
            where: '${DisabilityField.userid} = ?',
            whereArgs: [userid],
        );
        if(maps.isNotEmpty){
            return Disability.fromJson(maps.first);
        }else{
            throw Exception('ID $userid not found');
        }
    }
    Future<Reserve> readReserveBU(int userid) async{//BU = By User
        final db = await instance.database;
        final maps = await db.query(
            tableReserve,
            columns: ReserveField.values,
            where: '${ReserveField.userid} = ?',
            whereArgs: [userid],
        );
        if(maps.isNotEmpty){
            return Reserve.fromJson(maps.first);
        }else{
            throw Exception('ID $userid not found');
        }
    } 
    Future<Reserve> readReserveBP(int parkingid) async{//BP = By Parking Lot
        final db = await instance.database;
        final maps = await db.query(
            tableReserve,
            columns: ReserveField.values,
            where: '${ReserveField.parkingid} = ?',
            whereArgs: [parkingid],
        );
        if(maps.isNotEmpty){
            return Reserve.fromJson(maps.first);
        }else{
            throw Exception('ID $parkingid not found');
        }
    }    
    Future<Parked> readParked(int parkingid) async{
        final db = await instance.database;
        final maps = await db.query(
            tableParked,
            columns: ParkedField.values,
            where: '${ParkedField.parkingid} = ?',
            whereArgs: [parkingid],
        );
        if(maps.isNotEmpty){
            return Parked.fromJson(maps.first);
        }else{
            throw Exception('ID $parkingid not found');
        }
    }
    Future<bool> checkAdmin(int userid) async{
        final db = await instance.database;
        final maps = await db.query(
            tableAdmin,
            columns: AdminField.values,
            where: '${AdminField.userid} = ?',
            whereArgs: [userid],
        );
        if(maps.isNotEmpty){
            return true;
        }else{
            return false;
        }
    }
    Future<List<User>> readAllUsers() async{
        final db = await instance.database;
        final result = await db.query(tableUser);
        final userMap =result.map((json) => User.fromJson(json)).toList();
        for (User user in userMap) {
            print('User ID: ${user.userid}');
            print('Name: ${user.name}');
            print('Mail: ${user.mail}');
            print('Password: ${user.password}');
            print('Number: ${user.number}');
            print('-----------------------------');
        }
        return result.map((json) => User.fromJson(json)).toList();
    }
    Future<List<Parking>> readAllParkings() async{
        final db = await instance.database;
        final result = await db.query(tableParking);
        return result.map((json) => Parking.fromJson(json)).toList();
    }
    Future<List<Disability>> readAllDisabilitys() async{
        final db = await instance.database;
        final result = await db.query(tableDisability);
        return result.map((json) => Disability.fromJson(json)).toList();
    }
    Future<List<Reserve>> readAllReserves() async{
        final db = await instance.database;
        final result = await db.query(tableReserve);
        return result.map((json) => Reserve.fromJson(json)).toList();
    }
    Future<List<Parked>> readAllParkeds() async{
        final db = await instance.database;
        final result = await db.query(tableParked);
        return result.map((json) => Parked.fromJson(json)).toList();
    }
    Future<List<Admin>> readAllAdmins() async{
        final db = await instance.database;
        final result = await db.query(tableAdmin);
        return result.map((json) => Admin.fromJson(json)).toList();
    }
    Future<int> updateUser(User user) async{
        final db = await instance.database;
        return db.update(
            tableUser,
            user.toJson(),
            where: '${UserField.userid} = ?',
            whereArgs: [user.userid],
        );
    }
    Future<int> updateParking(Parking parking) async{
        final db = await instance.database;
        return db.update(
            tableParking,
            parking.toJson(),
            where: '${ParkingField.parkingid} = ?',
            whereArgs: [parking.parkingid],
        );
    }
    Future<int> updateDisability(Disability d) async{
        final db = await instance.database;
        return db.update(
            tableDisability,
            d.toJson(),
            where: '${DisabilityField.userid} = ?',
            whereArgs: [d.userid],
        );
    }
    Future<int> updateReserveBU(Reserve r) async{//BU = By User
        final db = await instance.database;
        return db.update(
            tableReserve,
            r.toJson(),
            where: '${ReserveField.userid} = ?',
            whereArgs: [r.userid],
        );
    }    
    Future<int> updateReserveBP(Reserve r) async{//BP = By Parking Lot
        final db = await instance.database;
        return db.update(
            tableReserve,
            r.toJson(),
            where: '${ReserveField.parkingid} = ?',
            whereArgs: [r.parkingid],
        );
    }    
    Future<int> updateParked(Parked p) async{
        final db = await instance.database;
        return db.update(
            tableParked,
            p.toJson(),
            where: '${ParkedField.parkingid} = ?',
            whereArgs: [p.parkingid],
        );
    }
    Future<int> deleteUser(int id) async{
        final db = await instance.database;
        return await db.delete(
            tableUser,
            where: '${UserField.userid} = ?',
            whereArgs: [id],
        );
    }
    Future<int> deleteParking(int id) async{
        final db = await instance.database;
        return await db.delete(
            tableParking,
            where: '${ParkingField.parkingid} = ?',
            whereArgs: [id],
        );
    }
    Future<int> deleteDisability(int id) async{
        final db = await instance.database;
        return await db.delete(
            tableDisability,
            where: '${DisabilityField.userid} = ?',
            whereArgs: [id],
        );
    }
    Future<int> deleteReserveBU(int id) async{ //BU = By User
        final db = await instance.database;
        return await db.delete(
            tableReserve,
            where: '${ReserveField.userid} = ?',
            whereArgs: [id],
        );
    }
    Future<int> deleteReserveBP(int id) async{//BP = By Parking Lot
        final db = await instance.database;
        return await db.delete(
            tableReserve,
            where: '${ReserveField.parkingid} = ?',
            whereArgs: [id],
        );
    }
    Future<int> deleteParked(int id) async{
        final db = await instance.database;
        return await db.delete(
            tableParked,
            where: '${ParkedField.parkingid} = ?',
            whereArgs: [id],
        );
    }
    Future<int> deleteAdmin(int id) async{
        final db = await instance.database;
        return await db.delete(
            tableAdmin,
            where: '${AdminField.userid} = ?',
            whereArgs: [id],
        );
    }
    Future close() async{
        final db = await instance.database;
        db.close();
    }
    Future<bool> readUserByEmailAndPassword(String email, String password) async {
      final db = await instance.database;
      final maps = await db.query(
        tableUser,
        columns: UserField.values,
        where: '${UserField.mail} = ? AND ${UserField.password} = ?',
        whereArgs: [email, password],
      );
      print("-----------------------------------asdasdasdas");
      print(email);
      print(password);
      print(maps);
      if (maps.isNotEmpty) {
        return true;
      } else {
        return false;
      }
   }

   Future<int?> getUserID(String email, String password) async {
   final db = await instance.database;
   final maps = await db.query(
   tableUser,
   columns: UserField.values,
   where: '${UserField.mail} = ? AND ${UserField.password} = ?',
   whereArgs: [email, password], );

   if (maps.isNotEmpty) {
     return maps[0][UserField.userid] as int?;
   } else {
     return null; // User not found
   }
 }
}

