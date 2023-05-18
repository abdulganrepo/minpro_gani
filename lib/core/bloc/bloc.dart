import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minpro_gani/core/bloc/event.dart';
import 'package:minpro_gani/core/bloc/state.dart';
import 'package:minpro_gani/core/models/detailuser_model.dart';
import 'package:minpro_gani/core/models/listofusers_model.dart';
import 'package:minpro_gani/core/models/response_new_user.dart';
import 'package:minpro_gani/core/services/services.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileService _service;
  ProfileBloc(this._service) : super(ProfileInitial());
  ProfileState get initialState => ProfileInitial();

  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is FetchListUsers) {
      yield ProfileLoading();

      try {
        ListUsersModel value = await _service.fetchListofUsers();
        if (value.data != null) {
          yield ProfileDisposeLoading();
          yield ProfileListUsersSuccess(value);
        } else {
          yield ProfileDisposeLoading();
          yield ProfileListUsersFailed();
        }
      } catch (e) {
        yield ProfileListUsersFailed();
      }
    }

    if (event is FetchDetailUserbyId) {
      yield ProfileLoading();

      try {
        DetailUserModel value = await _service.fetchDetailUser(event.id);
        if (value.data != null) {
          yield ProfileDisposeLoading();
          yield ProfileDetailUserSuccess(value);
        } else {
          yield ProfileDisposeLoading();
          yield ProfileDetailUserFailed();
        }
      } catch (e) {
        yield ProfileDetailUserFailed();
      }
    }

    if (event is AddNewUserService) {
      yield ProfileLoading();
      print("Add New User Status");
      try {
        ResponseNewUser value =
            await _service.addNewUser(event.name, event.job);

        yield ProfileDisposeLoading();
        yield AddNewUserSuccess(value);
      } catch (e) {
        print("Error : ${e.toString()}");
        yield ProfileDisposeLoading();
        yield AddNewUserFailed();
      }
    }
  }
}
