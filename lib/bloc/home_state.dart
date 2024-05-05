import 'package:equatable/equatable.dart';

import '../models/post_model.dart';

abstract class HomeState extends Equatable {}

class HomeInitialState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeErrorState extends HomeState {
  final String errorMessage;

  HomeErrorState(this.errorMessage);

  @override
  List<Object> get props => [];
}

class HomePostListState extends HomeState {
  final List<Post> postList;

  HomePostListState(this.postList);

  @override
  List<Object> get props => [postList];
}

class HomeDeletePostState extends HomeState {
  late final Post post;

  @override
  List<Object?> get props => [post];
}
