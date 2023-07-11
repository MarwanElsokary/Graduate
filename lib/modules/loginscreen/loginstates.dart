
abstract class loginstates {}
class loginIntialState extends loginstates {}
class loginLoadingState extends loginstates {}
class loginSucessState extends loginstates {
   final String uId;
   loginSucessState(this.uId);

}

class loginErrorState extends loginstates {
  final String error;
  loginErrorState(this.error);
}
class chagePassvisibilitystate extends loginstates {}
class role  extends loginstates {}