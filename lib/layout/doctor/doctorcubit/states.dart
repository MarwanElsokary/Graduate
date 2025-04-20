abstract class doctorLayoutstates {}
class intialstate  extends doctorLayoutstates{}
class changeBottomNavstate extends doctorLayoutstates{}
class doctorLoadingstate extends doctorLayoutstates{}
class chagePassvisibilitystate extends doctorLayoutstates{}
class doctorlogoutSucessState  extends doctorLayoutstates{}

// get data
class doctorGetuserLoadingState extends doctorLayoutstates{}
class doctorGetuserSucessState extends doctorLayoutstates{}
class doctorGetuserErrorState extends doctorLayoutstates{ final String error ;
doctorGetuserErrorState(this.error);}
// update profile
class doctorProfileImagePickedSucessState extends doctorLayoutstates{}
class doctorProfileImagePickedErrorState extends doctorLayoutstates{}

class doctorUploadProfileImageSucessState extends doctorLayoutstates{}
class doctorUploadProfileImageErrorState extends doctorLayoutstates{}

class doctorUpdateErrorState extends doctorLayoutstates{}
class doctorUpdateLoadingState extends doctorLayoutstates{}
class doctorUpdatesucessState extends doctorLayoutstates{}


//change password
class doctorChangePasswordLoadingState extends doctorLayoutstates{}
class doctorChangePasswordSucessState extends doctorLayoutstates{}
class doctorChangePasswordErrorState extends doctorLayoutstates{}
//post a case
class doctorNewPostLoadingState extends doctorLayoutstates{}
class doctorNewPostSucessState extends doctorLayoutstates{}
class doctorNewPostErrorState extends doctorLayoutstates{ final String error ;
doctorNewPostErrorState(this.error);}
class casePostImagePickedSuccessState extends doctorLayoutstates{}
class casePostImagePickedErrorState extends doctorLayoutstates{}

class casePostImageTakedSuccessState extends doctorLayoutstates{}
class casePostImageTakedErrorState extends doctorLayoutstates{}
class caseRemoveImageSuccessState extends doctorLayoutstates{}

class changeDiabetesSuccess extends doctorLayoutstates{}
class changeDiabetesError extends doctorLayoutstates{}

class changeCardiacSuccess extends doctorLayoutstates{}
class changeCardiacError extends doctorLayoutstates{}
class showCompleteSubcategoryMAX extends doctorLayoutstates{}
class showPartialSubcategoryMAX extends doctorLayoutstates{}
class showPartialSubcategoryMAN extends doctorLayoutstates{}
class showCompleteSubcategoryMAN extends doctorLayoutstates{}
class isMaxilloFacial extends doctorLayoutstates{}
class isfullmouth extends doctorLayoutstates{}

class loadingLabels extends doctorLayoutstates{}
class sucessloadingLabels extends doctorLayoutstates{}


class changeHypertensionSuccess extends doctorLayoutstates{}
class changeHypertensionError extends doctorLayoutstates{}

class changeAllergiesSuccess extends doctorLayoutstates{}
class changeAllergiesError extends doctorLayoutstates{}

class casePostImageCapturedSuccessState extends doctorLayoutstates{}
class casePostImageCapturedErrorState extends doctorLayoutstates{}

// get cases
class doctorGetCasesLoadingState extends doctorLayoutstates{}
class doctorGetCasesSucessState extends doctorLayoutstates{}
class doctorGetCasesErrorState extends doctorLayoutstates{ final String error ;
doctorGetCasesErrorState(this.error);}
// update cases
class doctorUpdateCasesLoadingState extends doctorLayoutstates{}
class doctorUpdateCasesSucessState extends doctorLayoutstates{}
class doctorUpdateCasesErrorState extends doctorLayoutstates{ final String error ;
doctorUpdateCasesErrorState(this.error);}
class doctorDeleteCasesSucessState extends doctorLayoutstates{}
class doctorDeleteCasesErrorState extends doctorLayoutstates{ final String error ;
doctorDeleteCasesErrorState(this.error);}
// get clickedcase
class doctorGetClickedCaseLoadingState extends doctorLayoutstates{}
class doctorGetClickedCaseSucessState extends doctorLayoutstates{}
class doctorGetClickedCaseErrorState extends doctorLayoutstates{ final String error ;
doctorGetClickedCaseErrorState(this.error);}
//get cases of currentdoctor

class doctorGetCasesPerDoctorSucessState extends doctorLayoutstates{}
class doctorSearchSucessState extends doctorLayoutstates{}