
import 'package:equatable/equatable.dart';

abstract class CreateEvent extends Equatable{
  const CreateEvent();

  @override
  List<Object?> get props=>[];
}

class CreatePostEvent extends CreateEvent{
  final String title;
  final String body;


  const CreatePostEvent(this.title, this.body);

  @override
  List<Object?> get props=>[title, body];
}

