class caseModel {
  String? uId;
  String? caseState;
  String? caseId;
  String? name;
  String? image;
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
  List<String> images = [];
  List<String>? studentRequests=[];


  caseModel({
    this.name,
    this.caseState,
    this.image,
    this.uId,
    this.caseId,
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
    this.maxillarySubCategory,
    this.maxillaryModification,
    this.mandibularCategory,
    this.mandibularSubCategory,
    this.mandibularModification,
    this.level,
    required this.images,
      this.  studentRequests,

  });
  caseModel.fromjson(Map<String, dynamic> json) {
    uId = json['uId'];
    caseState = json['caseState'];
    caseId = json['caseId'];
    name = json['name'];
    image = json['image'];
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
    maxillaryCategory = json['maxillaryCategory'];
    maxillarySubCategory = json['maxillarySubCategory'];
    maxillaryModification = json['maxillaryModification'];
    mandibularCategory = json['mandibularCategory'];
    mandibularSubCategory = json['mandibularSubCategory'];
    mandibularModification = json['mandibularModification'];
    level = json['level'];
    for (var value in json['images']) {
      images.add(value);
    };
    if(json['studentRequests'] !=null)
    for (var value in json['studentRequests']!) {
      studentRequests?.add(value);
    };

   }
  Map<String, dynamic> tomap() {
    return {
      'name': name,
      'image': image,
      'caseState': caseState,
      'uId': uId,
      'caseId': caseId,
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
      'studentRequests':studentRequests,

    };
  }
}
