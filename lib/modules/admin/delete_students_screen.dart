import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import '../../layout/admin/admincubit/cubit.dart';
import '../../layout/admin/admincubit/states.dart';
import '../../models/user_model.dart';
import '../../shared/styles/colors.dart';

class deleteStudentScreen extends StatelessWidget {
   var searchcon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<adminLayoutcubit, adminLayoutstates>(
      listener: (context, state) {},
      builder: (context, state) {
          var cubit =adminLayoutcubit.get(context).search;
        return ConditionalBuilder(
          condition:adminLayoutcubit.get(context).students.length > 0,
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Text('Students List'),
              actions: [
                IconButton(onPressed: (){ adminLayoutcubit.get(context). logoutAdmin(context);}, icon: Icon(IconBroken.Logout)),
                PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text('Delete All fourth year students'),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text('Delete All fifth year students'),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: Text('Delete All postgraduate students'),
                    ),
                    PopupMenuItem(
                      value: 4,
                      child: Text('Delete All'),
                    ),
                  ],
                  onSelected: (value) {
                    // Perform action based on selected value
                    switch (value) {
                      case 1:
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            title: Text(
                              'Delete All Accounts',
                              style: TextStyle(fontSize: 15),
                            ),
                            content: Text(
                                'Are you sure you want to permanently delete All fourth year Students accounts ?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                    adminLayoutcubit.get(context).deleteAll4Student();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );                              break;
                      case 2:
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            title: Text(
                              'Delete All Accounts',
                              style: TextStyle(fontSize: 15),
                            ),
                            content: Text(
                                'Are you sure you want to permanently delete All Fifth year Students accounts ?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                               adminLayoutcubit.get(context).deleteAll5Student();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        break;
                      case 3:
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            title: Text(
                              'Delete All Accounts',
                              style: TextStyle(fontSize: 15),
                            ),
                            content: Text(
                                'Are you sure you want to permanently delete All Postgraduate Students accounts ?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  adminLayoutcubit.get(context).deleteAllpostStudent();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );                             break;
                      case 4:
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            title: Text(
                              'Delete All Accounts',
                              style: TextStyle(fontSize: 15),
                            ),
                            content: Text(
                                'Are you sure you want to permanently delete All Students accounts ?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                    adminLayoutcubit.get(context).deleteAllStudent();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        break;
                    }
                  },
                ),

                SizedBox(
                  width: 18,
                ),
              ],
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                  children: [
                Padding(
              padding: const EdgeInsets.all(18),
                  child:
                    TextFormField(
                         controller: searchcon,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                    adminLayoutcubit.get(context).Search(searchcon.text);
                        },
                        validator: (String? value) {
                          if (value!.isEmpty)
                            return 'search must not be empty';
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric( horizontal: 16.0),
                          filled: true,
                          fillColor: Colors.white,
                           hintText: 'search by student ID',
                          counterText: '',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color:defaultcol,
                            ),
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                    ),
                ),
                  ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          buildItem(cubit[index], context),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 8.0,
                      ),
                      itemCount: cubit.length,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
        ],
                ),
              ),
          ),
          fallback: (context) => Scaffold(
            appBar: AppBar(
              title: Text('Students List'),
              actions: [
                IconButton(onPressed: (){ adminLayoutcubit.get(context). logoutAdmin(context);}, icon: Icon(IconBroken.Logout)),

                SizedBox(
                  width: 18,
                ),
              ],
            ),
            body: Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('images/nodataavailable.gif'),
                    //  width: 250,
                    //    height: 250,
                  ),
                  Text(
                    'Sorry We Can\'t Find Any Data ',
                    style: TextStyle(
                      fontSize: 20,
                      color: defaultcol,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildItem(userModel modell, context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5.0,
            margin: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      ConditionalBuilder(
                        condition: modell.image != null,
                        builder: (context) => Stack(
                          children: [
                            CircleAvatar(
                              radius: 35.0,
                              backgroundImage: NetworkImage(
                                '${modell.image}',
                              ),
                            ),
                          ],
                        ),
                        fallback: (context) => Stack(
                          children: [
                            CircleAvatar(
                              radius: 35.0,
                              backgroundImage:
                                  AssetImage('images/profileimage.jpg'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${modell.name}',
                                    style: TextStyle(
                                      height: 1.4,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Id: ${modell.studentId}',
                                    style: TextStyle(
                                      height: 1.4,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              IconButton(
                                  onPressed: ()  {
                                    showDialog(context: context,
                                      builder:(context) => AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        title: Text(
                                            'Delete Account',
                                            style: TextStyle(
                                              fontSize: 15
                                          ),
                                        ),
                                        content:  Text('Are you sure you want to permanently delete the account ?'),
                                        actions: [
                                           TextButton(
                                            onPressed: () {

                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              adminLayoutcubit.get(context).deleteStudent(modell.uId);
                                                Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),

                                        ],),
                                    );
                                  },
                                  icon: Icon(
                                    IconBroken.Delete,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
