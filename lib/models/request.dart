class requestModel {
  String? doctorid;
  String? doctorname;
  String? doctorimage;
  String? studentid;
  String? studentname;
  String? studentimage;
  String? dateTime;
  String? patientName;
  String? patientAge;
  String? currentMedications;
  String? gender;
  String? patientAddress;
  String? patientPhone;
  bool? isDiabetes;
  bool? isHypertension;
  bool? isCardiac;
  bool? isAllergies;
  String? others;
  String? maxillaryCategory;
  String? maxillarySubCategory;
  String? maxillaryModification;
  String? mandibularCategory;
  String? mandibularSubCategory;
  String? mandibularModification;
  String? level;
  String? allergies;
   List<String>images=[];
  String? requeststatus;
  String? supervisorid;
  String? caseid;
  String? requestid;

  requestModel({
    this.requestid,
    this.doctorid,
    this.doctorimage,
    this.doctorname,
    this.supervisorid,
    this.studentid,
    this.studentimage,
    this.studentname,
    this.dateTime,
    this.patientName,
    this.patientAge,
    this.gender,
    this.allergies,
    this.currentMedications,
    this.patientAddress,
    this.patientPhone,
    this.isDiabetes,
    this.isHypertension,
    this.isCardiac,
    this.isAllergies,
    this.others,
    this.maxillaryCategory,
    this. maxillarySubCategory,
    this. maxillaryModification,
    this.mandibularCategory,
    this. mandibularSubCategory,
    this. mandibularModification,
    this.level,
    required this.images ,
    this.requeststatus,
    this.caseid,
  });
  requestModel.fromjson(Map<String, dynamic> json) {
    requestid=json['requestId'];
    doctorname = json['doctorName'];
    doctorid = json['doctorId'];
    doctorimage = json['doctorImage'];
    studentname=json['studentName'];
    studentimage=json['studentImage'];
    dateTime = json['dateTime'];
    patientName = json['patientName'];
    patientAge = json['patientAge'];
    gender = json['gender'];
    allergies = json['allergies'];
    currentMedications = json['currentMedications'];
    patientAddress = json['patientAddress'];
    patientPhone = json['patientPhone'];
    isDiabetes = json['isDiabetes'];
    isHypertension = json['isHypertension'];
    isCardiac = json['isCardiac'];
    isAllergies = json['isAllergies'];
    others = json['others'];
    maxillaryCategory= json['maxillaryCategory'];
    maxillarySubCategory= json['maxillarySubCategory'];
    maxillaryModification= json['maxillaryModification'];
    mandibularCategory= json['mandibularCategory'];
    mandibularSubCategory= json['mandibularSubCategory'];
    mandibularModification= json['mandibularModification'];
    level = json['level'];
     requeststatus = json['requestStatus'];
    supervisorid = json['supervisorId'];
    studentid = json['studentId'];
    caseid = json['caseId'];
    for (var value in json['images']) {
      images?.add(value);
    };

  }
  Map<String, dynamic> tomap() {
    return {
      'requestId' :requestid,
       'dateTime': dateTime,
      'patientName': patientName,
      'patientAge': patientAge,
      'gender': gender,
      'currentMedications': currentMedications,
      'patientAddress': patientAddress,
      'patientPhone': patientPhone,
      'isDiabetes': isDiabetes,
      'isHypertension': isHypertension,
      'isCardiac': isCardiac,
      'isAllergies': isAllergies,
      'allergies': allergies,
      'others': others,
      'maxillaryCategory': maxillaryCategory,
      'maxillarySubCategory': maxillarySubCategory,
      'maxillaryModification': maxillaryModification,
      'mandibularCategory': mandibularCategory,
      'mandibularSubCategory': mandibularSubCategory,
      'mandibularModification': mandibularModification,
      'level': level,
      'images': images,
       'requestStatus': requeststatus,
      'studentId': studentid,
      'supervisorId': supervisorid,
      'doctorId': doctorid,
      'doctorImage': doctorimage,
      'doctorName': doctorname,
      'studentImage': studentimage,
      'studentName': studentname,
       'caseId': caseid,
     };
  }
}
