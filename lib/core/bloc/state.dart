import 'package:equatable/equatable.dart';
import 'package:minpro_gani/core/models/detailuser_model.dart';
import 'package:minpro_gani/core/models/listofusers_model.dart';
import 'package:minpro_gani/core/models/response_new_user.dart';

class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileDisposeLoading extends ProfileState {}

class ProfileListUsersFailed extends ProfileState {}

class ProfileDetailUserFailed extends ProfileState {}

class AddNewUserFailed extends ProfileState {}

class ProfileListUsersSuccess extends ProfileState {
  final _data;

  ProfileListUsersSuccess(this._data);
  ListUsersModel get value => _data;

  @override
  List<Object> get props => [_data];
}

class ProfileDetailUserSuccess extends ProfileState {
  final _data;

  ProfileDetailUserSuccess(this._data);
  DetailUserModel get value => _data;

  @override
  List<Object> get props => [_data];
}

class AddNewUserSuccess extends ProfileState {
  final _data;
  AddNewUserSuccess(this._data);
  ResponseNewUser get value => _data;
  @override
  // TODO: implement props
  List<Object> get props => [];
}
