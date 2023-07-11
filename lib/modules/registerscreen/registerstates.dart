
abstract class registerstates {}
class registerIntialState extends registerstates {}
class registerLoadingState extends registerstates {}
class registerSucessState extends registerstates {}
class registerErrorState extends registerstates {
  final String error;
  registerErrorState(this.error);
}
class registerChagePassvisibilitystate extends registerstates {}

class createUserSucessState extends registerstates {}
class createUserErrorState extends registerstates {
  final String error;
  createUserErrorState(this.error);
}
class GetSupervisorsDataSucessState extends registerstates {}