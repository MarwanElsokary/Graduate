

class userModel{
  String ?name;
  String ?phone;
  String ?email;
  String ?studentId;
  String ?role;
  String ? image;
  String ? uId;
  String ? level;
  String ? supervisorName ;
  String ? supervisorId;
  String ? fcmToken;

  userModel({
    this.name,
    this.phone,
    this.email,
    this.studentId,
    this.role,
    this.image,
    this.uId,
    this.level,
    this.supervisorName,
    this.supervisorId,
    this.fcmToken,
  });
  userModel.fromjson(Map<String,dynamic>json){
    name=json['name'];
    phone=json['phone'];
    studentId=json['studentId'];
    role=json['role'];
    image=json['image'];
    email=json['email'];
    uId=json['uId'];
    level=json['level'];
    supervisorName= json['supervisorName'];
    supervisorId=json['supervisorId'];
    fcmToken=json['fcmToken'];

  }
  Map<String,dynamic>  tomap(){
    return{
      'name': name,
      'phone':phone,
      'studentId':studentId,
      'role':role,
      'image':image,
      'email':email,
      'uId':uId,
      'level': level,
      'supervisorName':supervisorName,
      'supervisorId' : supervisorId,
      'fcmToken' :fcmToken,
       };

     }

}
