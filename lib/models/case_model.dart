class caseModel {
  String? uId;
  String? caseState;
  String? caseId;
  String? name;
  String? image;
  String? dateTime;
  String? patientName;
  String? patientAge;
  String? gender;
  String? allergies;
  String? currentMedications;
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
  List<String> images = [];
  List<String> studentRequests = [];

  caseModel({
    this.uId,
    this.caseState,
    this.caseId,
    this.name,
    this.image,
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
    required this.studentRequests,
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

    if (json['images'] != null) {
      for (var value in json['images']) {
        images.add(value);
      }
    }

    if (json['studentRequests'] != null) {
      for (var value in json['studentRequests']) {
        studentRequests.add(value);
      }
    }
  }

  Map<String, dynamic> tomap() {
    return {
      'uId': uId,
      'caseState': caseState,
      'caseId': caseId,
      'name': name,
      'image': image,
      'dateTime': dateTime,
      'patientName': patientName,
      'patientAge': patientAge,
      'gender': gender,
      'allergies': allergies,
      'currentMedications': currentMedications,
      'patientAddress': patientAddress,
      'patientPhone': patientPhone,
      'isDiabetes': isDiabetes,
      'isHypertension': isHypertension,
      'isCardiac': isCardiac,
      'isAllergies': isAllergies,
      'others': others,
      'maxillaryCategory': maxillaryCategory,
      'maxillarySubCategory': maxillarySubCategory,
      'maxillaryModification': maxillaryModification,
      'mandibularCategory': mandibularCategory,
      'mandibularSubCategory': mandibularSubCategory,
      'mandibularModification': mandibularModification,
      'level': level,
      'images': images,
      'studentRequests': studentRequests,
    };
  }
}
