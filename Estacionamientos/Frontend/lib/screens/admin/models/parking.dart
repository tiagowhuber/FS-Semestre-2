// ignore_for_file: prefer_const_declarations

final String tableUser = 'User';
final String tableParking = 'Parking';
final String tableDisability = 'Disability';
final String tableReserve = 'Reserve';
final String tableParked = 'Parked';
final String tableAdmin = 'Admin';

class UserField{
    static final List<String> values = [
        userid, name, mail, password, number, tipo
    ];
    static final String userid = '_userid';
    static final String name = 'name';
    static final String mail = 'mail';
    static final String password = 'password';
    static final String number = 'number';
    static const String tipo = 'tipo';
}

enum Tipo { 
  comun,
  discapacitado,
  reserva,
  suspendido,
}
class User{
    final int? userid;
    final String name;
    final String mail;
    final String password;
    final int number;
    final Tipo tipo;

    const User({
        this.userid,
        required this.name,
        required this.mail,
        required this.password,
        required this.number,
        this.tipo = Tipo.comun,

    });
    User copy({
        int? userid,
        String? name,
        String? mail,
        String? password,
        int? number,
        Tipo? tipo,
    }) =>
            User(
                userid: userid ?? this.userid,
                name: name ?? this.name,
                mail: mail ?? this.mail,
                password: password ?? this.password,
                number: number ?? this.number,
                tipo: tipo ?? this.tipo,
            );

    static User fromJson(Map<String, Object?> json) => User(
            userid: json[UserField.userid] as int?,
            name: json[UserField.name] as String,
            mail: json[UserField.mail] as String,
            password: json[UserField.password] as String,
            number: json[UserField.number] as int,
            tipo: Tipo.values[json[UserField.tipo] as int],
    );
    Map<String, Object?> toJson()=>{
        UserField.userid: userid,
        UserField.name: name,
        UserField.mail: mail,
        UserField.password: password,
        UserField.number: number,  
        UserField.tipo: tipo.index,
    };
}
class ParkingField{
    static final List<String> values = [
        parkingid, location, state, type
    ];
    static final String parkingid = '_parkingid';
    static final String location = 'location';
    static final String state = 'state';
    static final String type = 'type';
}
class Parking{
    final int? parkingid;
    final String location;
    final String state;
    final String type;    
    
    const Parking({
        this.parkingid,
        required this.location,
        required this.state,
        required this.type,
    });
    Parking copy({
        int? parkingid,
        String? location,
        String? state,
        String? type,
    }) =>
            Parking(
                parkingid: parkingid ?? this.parkingid,
                location: location ?? this.location,
                state: state ?? this.state,
                type: type ?? this.type,
            );

    static Parking fromJson(Map<String, Object?> json) => Parking(
            parkingid: json[ParkingField.parkingid] as int?,
            location: json[ParkingField.location] as String,
            state: json[ParkingField.state] as String,
            type: json[ParkingField.type] as String,
    );
    Map<String, Object?> toJson()=>{
        ParkingField.parkingid: parkingid,
        ParkingField.location: location,
        ParkingField.state: state,  
        ParkingField.type: type,
    };
}
class DisabilityField{
    static final List<String> values = [
        userid, typeOfDisability
    ];
    static final String userid = '_userid';
    static final String typeOfDisability = 'typeOfDisability';
}
class Disability{
    final int? userid;
    final String typeOfDisability;    
    
    const Disability({
        required this.userid,
        required this.typeOfDisability,
    });
    Disability copy({
        int? userid,
        String? typeOfDisability
    }) =>
            Disability(
                userid: userid ?? this.userid,
                typeOfDisability: typeOfDisability ?? this.typeOfDisability,
            );

    static Disability fromJson(Map<String, Object?> json) => Disability(
            userid: json[DisabilityField.userid] as int?,
            typeOfDisability: json[DisabilityField.typeOfDisability] as String,
    );
    Map<String, Object?> toJson()=>{
        DisabilityField.userid: userid,
        DisabilityField.typeOfDisability: typeOfDisability,
    };
}
class ReserveField{    
  static final List<String> values = [
        userid, parkingid, admPos
    ];
    static final String userid = '_userid';
    static final String parkingid = '_parkingid';
    static final String admPos = 'admPos';
}
class Reserve{
    final int? userid;
    final int? parkingid;
    final String admPos; //Puesto Administrativo
    
    const Reserve({
        this.userid,
        this.parkingid,
        required this.admPos,
    });
    Reserve copy({
        int? userid,
        int? parkingid,
        String? admPos,
    }) =>
            Reserve(
                userid: userid ?? this.userid,
                parkingid: parkingid ?? this.parkingid,
                admPos: admPos ?? this.admPos,
            );

    static Reserve fromJson(Map<String, Object?> json) => Reserve(
            userid: json[ReserveField.userid] as int?,
            parkingid: json[ReserveField.parkingid] as int?,
            admPos: json[ReserveField.admPos] as String,
    );
    Map<String, Object?> toJson()=>{
        ReserveField.userid: userid,
        ReserveField.parkingid: parkingid,
        ReserveField.admPos: admPos,
    };
}
class ParkedField{    
  static final List<String> values = [
        userid, parkingid, admPos
    ];
    static final String parkingid = '_parkingid';
    static final String userid = '_userid';
    static final String admPos = 'admPos';
}
class Parked{
    final int? parkingid;
    final int? userid;
    
    const Parked({
        required this.parkingid,
        this.userid,
    });
    Parked copy({
        int? userid,
        int? parkingid,
    }) =>
            Parked(
                userid: userid ?? this.userid,
                parkingid: parkingid ?? this.parkingid,
            );

    static Parked fromJson(Map<String, Object?> json) => Parked(
            userid: json[ParkedField.userid] as int?,
            parkingid: json[ParkedField.parkingid] as int?,
    );
    Map<String, Object?> toJson()=>{
        ParkedField.userid: userid,
        ParkedField.parkingid: parkingid,
    };
}
class AdminField{    
  static final List<String> values = [
        userid
    ];
    static final String userid = '_userid';
}
class Admin{
    final int? userid;
    const Admin({
        this.userid,
    });
    Admin copy({
        int? userid,
    }) =>
            Admin(
                userid: userid ?? this.userid,
            );

    static Admin fromJson(Map<String, Object?> json) => Admin(
            userid: json[AdminField.userid] as int?,
    );
    Map<String, Object?> toJson()=>{
        AdminField.userid: userid,
    };
}
