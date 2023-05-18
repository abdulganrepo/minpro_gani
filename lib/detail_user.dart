import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minpro_gani/core/bloc/bloc.dart';
import 'package:minpro_gani/core/bloc/event.dart';
import 'package:minpro_gani/core/bloc/state.dart';
import 'package:minpro_gani/utils/loading.dart';
import 'package:shimmer/shimmer.dart';

class DetailUser extends StatefulWidget {
  int id;
  DetailUser({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  var firstName;
  var lastName;
  var email;
  var avatar;
  var textSupp;

  @override
  // ignore: must_call_super
  void initState() {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(FetchDetailUserbyId(widget.id));
    print("First State");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Detail User",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                ))),
        body: BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoading) {
                onLoading(context);
              }

              if (state is ProfileDisposeLoading) {
                Navigator.of(context, rootNavigator: true).pop();
              }

              if (state is ProfileDetailUserSuccess) {
                setState(() {
                  firstName = state.value.data?.firstName;
                  lastName = state.value.data?.lastName;
                  email = state.value.data?.email;
                  avatar = state.value.data?.avatar;
                  textSupp = state.value.support?.text;
                });
                print(firstName);
                print(lastName);
                print(email);
                print(avatar);
              }
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                      margin: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          avatar != null
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(avatar),
                                  radius: 50.0,
                                  backgroundColor:
                                      const Color.fromARGB(255, 94, 95, 95),
                                )
                              : const CircleAvatar(
                                  backgroundColor: Colors.grey,
                                ),
                          Container(
                            padding: const EdgeInsets.all(30),
                            child: firstName != null && lastName != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "$firstName $lastName",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(height: 10),
                                      Text("$email"),
                                    ],
                                  )
                                : Column(),
                          )
                        ],
                      )),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Divider(
                      color: Colors.grey,
                      thickness: 2,
                    ),
                  ),
                  const Text("SUPPORT",
                      style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  textSupp == null
                      ? const Text("Loading....")
                      : Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Text("$textSupp")),
                ],
              ),
            )));
  }
}

Widget emptyList() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Text("Tidak ada data user"),
      ],
    ),
  );
}
