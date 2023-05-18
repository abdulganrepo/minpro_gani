import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minpro_gani/core/bloc/bloc.dart';
import 'package:minpro_gani/core/bloc/event.dart';
import 'package:minpro_gani/core/bloc/state.dart';
import 'package:minpro_gani/core/models/selector_model.dart';
import 'package:minpro_gani/core/services/services.dart';
import 'package:minpro_gani/detail_user.dart';
import 'package:minpro_gani/utils/loading.dart';

class ListUsersView extends StatefulWidget {
  const ListUsersView({Key? key}) : super(key: key);

  @override
  State<ListUsersView> createState() => _ListUsersViewState();
}

class _ListUsersViewState extends State<ListUsersView> {
  List<SelectorProfileListUsers> listUsers = [];
  @override
  // ignore: must_call_super
  void initState() {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    profileBloc.add(FetchListUsers());
    print("First State");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Center(
            child: Text(
              "List of Users",
              style: TextStyle(color: Colors.black),
            ),
          ),
          backgroundColor: Colors.white),
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoading) {
            onLoading(context);
          }

          if (state is ProfileDisposeLoading) {
            Navigator.of(context, rootNavigator: true).pop();
          }

          if (state is ProfileListUsersSuccess) {
            debugPrint('profile list users');
            state.value.data?.forEach((f) {
              // ignore: unnecessary_null_comparison
              if (f != null) {
                listUsers.add(SelectorProfileListUsers(
                    id: f.id,
                    email: f.email,
                    firstName: f.firstName,
                    lastName: f.lastName,
                    avatar: f.avatar));
              }
            });
            for (var i = 0; i < listUsers.length; i++) {
              print(listUsers[i].id);
              print(listUsers[i].firstName);
            }
          }
        },
        child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileListUsersSuccess) {
            // ignore: unnecessary_null_comparison
            if (listUsers == null) {
              return emptyList();
            } else {
              return ListView.builder(
                  // ignore: prefer_if_null_operators, unnecessary_null_comparison
                  itemCount: listUsers.length == null ? 0 : listUsers.length,
                  itemBuilder: (context, index) {
                    var data = listUsers[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider<ProfileBloc>(
                              create: (context) =>
                                  ProfileBloc(ProfileService()),
                              child: DetailUser(id: data.id.hashCode),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          leading: Image.network("${data.avatar}", height: 72),
                          title: Text('${data.firstName} ${data.lastName}'),
                          subtitle: Text('${data.email}'),
                          // trailing: const Icon(Icons.more_vert),
                          isThreeLine: true,
                        ),
                      ),
                    );
                  });
            }
          }
          if (state is ProfileListUsersFailed) {
            return emptyList();
          }
          return const SizedBox();
        }),
      ),
    );
  }
}

Widget emptyList() {
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        Center(child: Text("Tidak ada data User")),
      ],
    ),
  );
}
