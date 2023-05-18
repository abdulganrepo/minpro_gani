import 'package:equatable/equatable.dart';

class ProfileEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchListUsers extends ProfileEvent {
  FetchListUsers();

  @override
  List<Object> get props => [];
}

class FetchDetailUserbyId extends ProfileEvent {
  final int id;

  FetchDetailUserbyId(this.id);

  @override
  List<Object> get props => [id];
}

class AddNewUserService extends ProfileEvent {
  final String name;
  final String job;
  AddNewUserService(this.name, this.job);

  @override
  // TODO: implement props
  List<Object> get props => [name, job];
}
