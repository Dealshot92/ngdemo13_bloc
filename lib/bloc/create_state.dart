import 'package:equatable/equatable.dart';

import '../models/post_model.dart';

abstract class CreateState extends Equatable {
  const CreateState();

  @override
  List<Object?> get props => [];
}

class CreateInitialState extends CreateState {}

class CreateLoadingState extends CreateState {}

class CreatedPostState extends CreateState {
  final Post post;

  const CreatedPostState(this.post);

  @override
  List<Object?> get props => [post];
}

class CreateErrorState extends CreateState {
  final String errorMessage;

  const CreateErrorState(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
