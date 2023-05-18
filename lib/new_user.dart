import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minpro_gani/core/bloc/bloc.dart';
import 'package:minpro_gani/core/bloc/event.dart';
import 'package:minpro_gani/core/bloc/state.dart';
import 'package:minpro_gani/utils/loading.dart';

class NewUser extends StatefulWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  var id;
  var name;
  var job;
  var createdAt;

  // ignore: prefer_final_fields
  var _formKey = GlobalKey<FormState>();
  var nameCtrl = TextEditingController();
  var jobCtrl = TextEditingController();

  void addNewUSer(String name, String job) async {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(AddNewUserService(name, job));
    print(nameCtrl.text);
    print(jobCtrl.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Add New User",
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.white,
      ),
      resizeToAvoidBottomInset: true,
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoading) {
            onLoading(context);
          }

          if (state is ProfileDisposeLoading) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          if (state is AddNewUserSuccess) {
            if (state.value.name == "" && state.value.job == "") {
              return showFailAlertDialog(context);
            }
            if (state.value.name != "" && state.value.job != "") {
              setState(() {
                id = state.value.id;
                name = state.value.name;
                job = state.value.job;
                createdAt = state.value.createdAt;
              });
              print(id);
              print(createdAt);
              return showAlertDialog(context, id, name, job, createdAt);
            }
          }
        },
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person, color: Colors.black),
                    hintText: 'What do people call you?',
                    hintStyle: TextStyle(color: Colors.black),
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  controller: nameCtrl,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.assessment_rounded, color: Colors.black),
                    hintText: 'Tell me more about you',
                    hintStyle: TextStyle(color: Colors.black),
                    labelText: 'Job',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                  controller: jobCtrl,
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      // ignore: unnecessary_null_comparison
                      // if (nameCtrl.text.isEmpty) {
                      //   showAlertDialog(context, "Name");
                      // } else if (jobCtrl.text.isEmpty) {
                      //   showAlertDialog(context, "Job");
                      // }
                      addNewUSer(nameCtrl.text, jobCtrl.text);
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.black)),
                    child: const Text("Save"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(
    BuildContext context, String id, String name, String job, String creatdAt) {
  final snackbar = SnackBar(
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Add New User Success'),
        const SizedBox(height: 5),
        Text('Id : $id '),
        Text('Name : $name '),
        Text('Job : $job '),
        Text('Created At : $creatdAt'),
      ],
    ),
    duration: Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

void showFailAlertDialog(BuildContext context) {
  final snackbar = SnackBar(
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text('ERROR'),
        Text('All fields are required .....'),
      ],
    ),
    duration: Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
