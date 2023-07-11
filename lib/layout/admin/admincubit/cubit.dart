import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:project/shared/components/components.dart';
import 'package:project/shared/components/constants.dart';
import 'package:project/shared/network/local/cache_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/layout/admin/admincubit/states.dart';
import 'package:project/modules/admin/delete%20_supervisors_screen.dart';
import 'package:project/modules/admin/delete_doctors_screen.dart';
import 'package:project/modules/admin/delete_students_screen.dart';
import '../../../models/user_model.dart';
import '../../../modules/loginscreen/loginScreen.dart';

class adminLayoutcubit extends Cubit<adminLayoutstates> {
  adminLayoutcubit() : super(intialstate());

  static adminLayoutcubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> adminbottomScreens = [
    deleteStudentScreen(),
    deleteDoctorScreen(),
    deleteSuperScreen(),
  ];
  void changebottomadmin(int index) {
    currentIndex = index;
    emit(changeBottomNavstate());
  }

  //get all students
  List<userModel> students = [];
  List<userModel> search = [];
  Future<void> getStudents() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'student')
        .snapshots()
        .listen((event) {
      students = [];
      search = [];
      event.docs.forEach((element) {
        students.add(userModel.fromjson(element.data()));
        search.add(userModel.fromjson(element.data()));
      });
      emit(admingetStudentsSucessState());
    });
  }

  //search for student by id
  void Search(String query) {
    if (query.isNotEmpty) {
      search = students
          .where((item) => item.studentId!.contains(query.toLowerCase()))
          .toList();
    } else {
      getStudents();
    }
    emit(SearchSucessState());
  }

  //get all doctors
  List<userModel> doctors = [];
  Future<void> getDoctors() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'Doctor')
        .snapshots()
        .listen((event) {
      doctors = [];
      event.docs.forEach((element) {
        doctors.add(userModel.fromjson(element.data()));
      });
      emit(admingetDoctorsSucessState());
    });
  }

  //get all supervisors
  List<userModel> supervisors = [];
  Future<void> getSupervisors() async {
    FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'Supervisor')
        .snapshots()
        .listen((event) {
      supervisors = [];
      event.docs.forEach((element) {
        supervisors.add(userModel.fromjson(element.data()));
      });
      emit(admingetSupervisorsSucessState());
    });
  }

  //logout
  Future<void> logoutAdmin(context) async {
    await FirebaseAuth.instance.signOut();

    // Remove user ID and role data from cache
    await cacheHelper.removedata(key: 'uId');
    await cacheHelper.removedata(key: 'role');
    await FirebaseMessaging.instance.unsubscribeFromTopic(UID);
    navigate(context, loginScreen());
    emit(adminlogoutSucessState());
  }

  //delete  supervisor by id
  Future<void> deleteSupervisor(uid) async {
    try {
      //delete user from auth
      await admin.auth().deleteUser(uid);
      print(
          'User with ID $uid successfully deleted from Firebase Authentication.');
      //delete requests to user
      await FirebaseFirestore.instance
          .collection('requests')
          .where('supervisorId', isEqualTo: uid)
          .get()
          .then((value) async {
        print(value.docs.length);

        value.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection('requests')
              .doc(element.id)
              .delete()
              .then((value) {
            print('requests deleted successfully');
          }).catchError((error) {
            print('Error deleting requests: $error');
          });
        });
      });
      //delete username&id from students
      await FirebaseFirestore.instance
          .collection('users')
          .where('supervisorId', isEqualTo: uid)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          FirebaseFirestore.instance.collection('users').doc(element.id).update(
              {'supervisorId': null, 'supervisorName': null}).then((value) {
            print('supervisor removed from student successfully');
          }).catchError((error) {
            print('Error updating requests: $error');
          });
        });
      });
      //delete user from users table
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      print('User data with ID $uid successfully deleted from  Database.');
      showtoast(text: 'Deleted Successfully', state: toaststates.SUCCESS);

      emit(deleteSuperScuessState());
    } catch (e) {
      print('Error deleting user: $e');
      emit(deleteSuperErrorState());
    }
  }

  //delete  student by id
  Future<void> deleteStudent(uid) async {
    try {
      //delete user from auth
      await admin.auth().deleteUser(uid);
      print(
          'User with ID $uid successfully deleted from Firebase Authentication.');
      //delete requests to user
      await FirebaseFirestore.instance
          .collection('requests')
          .where('studentId', isEqualTo: uid)
          .get()
          .then((value) async {
        print(value.docs.length);

        value.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection('requests')
              .doc(element.id)
              .delete()
              .then((value) {
            print('requests deleted successfully');
          }).catchError((error) {
            print('Error deleting requests: $error');
          });
        });
      });
      //delete user from users table
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      print('User data with ID $uid successfully deleted from  Database.');
      showtoast(text: 'Deleted Sucessfully', state: toaststates.SUCCESS);
      emit(deleteStudentScuessState());
    } catch (e) {
      print('Error deleting user: $e');
      emit(deleteStudentErrorState());
    }
  }

  //delete  doctor by id
  Future<void> deletedoctor(uid) async {
    try {
      //delete user from auth
      await admin.auth().deleteUser(uid);
      print(
          'User with ID $uid successfully deleted from Firebase Authentication.');
      //delete requests to user
      await FirebaseFirestore.instance
          .collection('requests')
          .where('doctorId', isEqualTo: uid)
          .get()
          .then((value) async {
        print(value.docs.length);

        value.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection('requests')
              .doc(element.id)
              .delete()
              .then((value) {
            print('requests deleted successfully');
          }).catchError((error) {
            print('Error deleting requests: $error');
          });
        });
      });
      //delete cases of user
      await FirebaseFirestore.instance
          .collection('cases')
          .where('uId', isEqualTo: uid)
          .get()
          .then((value) async {
        print(value.docs.length);

        value.docs.forEach((element) {
          FirebaseFirestore.instance
              .collection('cases')
              .doc(element.id)
              .delete()
              .then((value) {
            print('cases deleted successfully');
          }).catchError((error) {
            print('Error deleting requests: $error');
          });
        });
      });
      //delete user from users table
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();
      print('User data with ID $uid successfully deleted from  Database.');
      showtoast(text: 'Deleted Successfully', state: toaststates.SUCCESS);

      emit(deleteDoctorScuessState());
    } catch (e) {
      print('Error deleting user: $e');
      emit(deleteDoctorErrorState());
    }
  }

  //delete all supervisors
  Future<void> deleteAllSupervisors() async {
    try {
      print('object');
      FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Supervisor')
          .get()
          .then((value) async {
        for (var element in value.docs) {
          print(element.data()['email']);
          //delete user from auth
          await admin.auth().deleteUser(element.data()['uId']);
          print('User   successfully deleted from Firebase Authentication.');
          //delete requests to user
          await FirebaseFirestore.instance
              .collection('requests')
              .where('supervisorId', isEqualTo: element.data()['uId'])
              .get()
              .then((value) async {
            print(value.docs.length);
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('requests')
                  .doc(element.id)
                  .delete()
                  .then((value) {
                print('requests deleted successfully');
              }).catchError((error) {
                print('Error deleting requests: $error');
              });
            });
          });
          //delete username&id from students
          await FirebaseFirestore.instance
              .collection('users')
              .where('supervisorId', isEqualTo: element.data()['uId'])
              .get()
              .then((value) {
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(element.id)
                  .update({'supervisorId': null, 'supervisorName': null}).then(
                      (value) {
                print('supervisor removed from student successfully');
              }).catchError((error) {
                print('Error updating requests: $error');
              });
            });
          });
          //delete user from users table
          await FirebaseFirestore.instance
              .collection('users')
              .doc(element.data()['uId'])
              .delete();
          print('User data w  successfully deleted from  Database.');
          showtoast(text: 'Deleted Successfully', state: toaststates.SUCCESS);
        }
      });
      emit(deleteALLSuperScuessState());
    } catch (e) {
      print('Error deleting supervisor users: $e');
      emit(deleteALLSuperErrorState());
    }
  }

  //delete all doctors
  Future<void> deleteAllDoctors() async {
    try {
      print('object');
      FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Doctor')
          .get()
          .then((value) async {
        for (var element in value.docs) {
          print(element.data()['email']);
          await admin.auth().deleteUser(element.data()['uId']);
          print(
              'User with ID  successfully deleted from Firebase Authentication.');
          //delete requests to user
          await FirebaseFirestore.instance
              .collection('requests')
              .where('doctorId', isEqualTo: element.data()['uId'])
              .get()
              .then((value) async {
            print(value.docs.length);
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('requests')
                  .doc(element.id)
                  .delete()
                  .then((value) {
                print('requests deleted successfully');
              }).catchError((error) {
                print('Error deleting requests: $error');
              });
            });
          });
          //delete requests of user
          await FirebaseFirestore.instance
              .collection('cases')
              .where('uId', isEqualTo: element.data()['uId'])
              .get()
              .then((value) async {
            print(value.docs.length);

            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('cases')
                  .doc(element.id)
                  .delete()
                  .then((value) {
                print('cases deleted successfully');
              }).catchError((error) {
                print('Error deleting requests: $error');
              });
            });
          });
          //delete user from users table
          await FirebaseFirestore.instance
              .collection('users')
              .doc(element.data()['uId'])
              .delete();
          print('User data with ID  successfully deleted from  Database.');
          showtoast(text: 'Deleted Successfully', state: toaststates.SUCCESS);
        }
        emit(deleteALLDoctorScuessState());
      });
    } catch (e) {
      print('Error deleting supervisor users: $e');
      emit(deleteALLDoctorErrorState());
    }
  }

  //delete all students
  Future<void> deleteAllStudent() async {
    try {
      print('object');
      FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'student')
          .get()
          .then((value) async {
        for (var element in value.docs) {
          await admin.auth().deleteUser(element.data()['uId']);
          print(
              'User with ID  successfully deleted from Firebase Authentication.');
          //delete requests to user
          await FirebaseFirestore.instance
              .collection('requests')
              .where('studentId', isEqualTo: element.data()['uId'])
              .get()
              .then((value) async {
            print(value.docs.length);
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('requests')
                  .doc(element.id)
                  .delete()
                  .then((value) {
                print('requests deleted successfully');
              }).catchError((error) {
                print('Error deleting requests: $error');
              });
            });
          });
          //delete user from users table
          await FirebaseFirestore.instance
              .collection('users')
              .doc(element.data()['uId'])
              .delete();
          print('User data with ID   successfully deleted from  Database.');
          showtoast(text: 'Deleted Successfully', state: toaststates.SUCCESS);
        }
        emit(deleteALLStudentScuessState());
      });
    } catch (e) {
      print('Error deleting supervisor users: $e');
      emit(deleteALLStudentErrorState());
    }
  }

  //delete all students by level
  Future<void> deleteAll4Student() async {
    try {
      print('object');
      FirebaseFirestore.instance
          .collection('users')
          .where('level', isEqualTo: 'Level 4')
          .get()
          .then((value) async {
        for (var element in value.docs) {
          await admin.auth().deleteUser(element.data()['uId']);
          print(
              'User with ID  successfully deleted from Firebase Authentication.');
          //delete requests to user
          await FirebaseFirestore.instance
              .collection('requests')
              .where('studentId', isEqualTo: element.data()['uId'])
              .get()
              .then((value) async {
            print(value.docs.length);

            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('requests')
                  .doc(element.id)
                  .delete()
                  .then((value) {
                print('requests deleted successfully');
              }).catchError((error) {
                print('Error deleting requests: $error');
              });
            });
          });
          //delete user from users table
          await FirebaseFirestore.instance
              .collection('users')
              .doc(element.data()['uId'])
              .delete();
          print('User data with ID   successfully deleted from  Database.');
          showtoast(text: 'Deleted Sucessfully', state: toaststates.SUCCESS);
        }
        emit(deleteALL4StudentScuessState());
      });
    } catch (e) {
      print('Error deleting supervisor users: $e');
      emit(deleteALL4StudentErrorState());
    }
  }

  Future<void> deleteAll5Student() async {
    try {
      print('object');
      FirebaseFirestore.instance
          .collection('users')
          .where('level', isEqualTo: 'Level 5')
          .get()
          .then((value) async {
        for (var element in value.docs) {
          await admin.auth().deleteUser(element.data()['uId']);
          print(
              'User with ID  successfully deleted from Firebase Authentication.');
          //delete requests to user
          await FirebaseFirestore.instance
              .collection('requests')
              .where('studentId', isEqualTo: element.data()['uId'])
              .get()
              .then((value) async {
            print(value.docs.length);

            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('requests')
                  .doc(element.id)
                  .delete()
                  .then((value) {
                print('requests deleted successfully');
              }).catchError((error) {
                print('Error deleting requests: $error');
              });
            });
          });
          //delete user from users table
          await FirebaseFirestore.instance
              .collection('users')
              .doc(element.data()['uId'])
              .delete();
          print('User data with ID   successfully deleted from  Database.');
          showtoast(text: 'Deleted Successfully', state: toaststates.SUCCESS);
        }
        emit(deleteALL5StudentScuessState());
      });
    } catch (e) {
      print('Error deleting supervisor users: $e');
      emit(deleteALL5StudentErrorState());
    }
  }

  Future<void> deleteAllpostStudent() async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .where('level', isEqualTo: 'Postgraduate ')
          .get()
          .then((value) async {
        for (var element in value.docs) {
          await admin.auth().deleteUser(element.data()['uId']);
          print(
              'User with ID  successfully deleted from Firebase Authentication.');
          //delete requests to user
          await FirebaseFirestore.instance
              .collection('requests')
              .where('studentId', isEqualTo: element.data()['uId'])
              .get()
              .then((value) async {
            print(value.docs.length);
            value.docs.forEach((element) {
              FirebaseFirestore.instance
                  .collection('requests')
                  .doc(element.id)
                  .delete()
                  .then((value) {
                print('requests deleted successfully');
              }).catchError((error) {
                print('Error deleting requests: $error');
              });
            });
          });
          //delete user from users table
          await FirebaseFirestore.instance
              .collection('users')
              .doc(element.data()['uId'])
              .delete();
          print('User data with ID   successfully deleted from  Database.');
          showtoast(text: 'Deleted Successfully', state: toaststates.SUCCESS);
        }
        emit(deleteALLpostStudentScuessState());
      });
    } catch (e) {
      print('Error deleting supervisor users: $e');
      emit(deleteALLpostStudentErrorState());
    }
  }
}
