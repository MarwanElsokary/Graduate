import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/layout/student/studentcubit/cubit.dart';

abstract class studentLayoutstates {}

class studentIntialstate extends studentLayoutstates {}
class setupInteractedMessage extends studentLayoutstates {

}



class studentChangeBottomNavstate extends studentLayoutstates {}

class studentChagePassvisibilitystate extends studentLayoutstates {}

class studentlogoutSucessState extends studentLayoutstates {}

class studentGetuserLoadingState extends studentLayoutstates {}

class studentGetuserSucessState extends studentLayoutstates {}

class studentGetuserErrorState extends studentLayoutstates {
  final String error;
  studentGetuserErrorState(this.error);
}
// update profile

class studentProfileImagePickedSucessState extends studentLayoutstates {}

class studentProfileImagePickedErrorState extends studentLayoutstates {}

class studentUploadProfileImageSucessState extends studentLayoutstates {}

class studentUploadProfileImageErrorState extends studentLayoutstates {}

class studentUpdateErrorState extends studentLayoutstates {}

class studentUpdateScuessState extends studentLayoutstates {}

class studentUpdateLoadingState extends studentLayoutstates {}

class studentGetSupervisorsDataSucessState extends studentLayoutstates {}

//change password
class studentChangePasswordLoadingState extends studentLayoutstates {}

class studentChangePasswordSucessState extends studentLayoutstates {}

class studentChangePasswordErrorState extends studentLayoutstates {}

// get cases
class studentGetCasesLoadingState extends studentLayoutstates {}

class studentGetCasesSucessState extends studentLayoutstates {}

class studentGetCasesErrorState extends studentLayoutstates {
  final String error;
  studentGetCasesErrorState(this.error);
}

// get clickedcase
class studentGetClickedCaseLoadingState extends studentLayoutstates {}

class studentGetClickedCaseSucessState extends studentLayoutstates {}

class studentGetClickedCaseErrorState extends studentLayoutstates {
  final String error;
  studentGetClickedCaseErrorState(this.error);
}

// get categorycases
class studentGetMaxilloCasesSucessState extends studentLayoutstates {}

class studentGetfullMouthCasesSucessState extends studentLayoutstates {}

class studentGetOverCasesSucessState extends studentLayoutstates {}

class studentGetSingleCasesSucessState extends studentLayoutstates {}

class studentGetCompleteCasesSucessState extends studentLayoutstates {}

class studentGetCompleteCasesLoadingState extends studentLayoutstates {}

class studentGetCompleteFlatCasesSucessState extends studentLayoutstates {}

class studentGetCompleteWellCasesSucessState extends studentLayoutstates {}

class studentGetPartialCasesSucessState extends studentLayoutstates {}

class studentGetPartial1CasesSucessState extends studentLayoutstates {}

class studentGetPartial2CasesSucessState extends studentLayoutstates {}

class studentGetPartial3CasesSucessState extends studentLayoutstates {}

class studentGetPartial4CasesSucessState extends studentLayoutstates {}

//create request
class studentCreateRequestLoadingState extends studentLayoutstates {}

class studentCreateRequestSucessState extends studentLayoutstates {}

class studentCreateRequestErrorState extends studentLayoutstates {
  final String error;
  studentCreateRequestErrorState(this.error);
}

//delete request
class studentDeleteRequestSucessState extends studentLayoutstates {}

class studentDeleteRequestErrorState extends studentLayoutstates {}

class studentGetRequestsSucessState extends studentLayoutstates {}

class studentGetSupervisorRequestedCasesLoadingState
    extends studentLayoutstates {}

class studentGetSupervisorRequestedCasesSucessState
    extends studentLayoutstates {}

class studentSearchSucessState extends studentLayoutstates {}
