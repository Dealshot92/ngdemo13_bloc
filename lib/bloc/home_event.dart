import 'package:equatable/equatable.dart';

import '../models/post_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadPostListEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class DeletePostEvent extends HomeEvent {
  final Post post;

  const DeletePostEvent({required this.post});

  @override
  List<Object?> get props => [post];
}
