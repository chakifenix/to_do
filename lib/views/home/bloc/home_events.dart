part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadTasksFetch extends HomeEvent {
  final String? filter;

  const LoadTasksFetch({required this.filter});
}

class AddNewTaskFetch extends HomeEvent {
  final Task task;

  const AddNewTaskFetch({required this.task});
}

class DeleteTaskFetch extends HomeEvent {
  final String id;
  const DeleteTaskFetch({required this.id});
}

class UpdateTaskFetch extends HomeEvent {
  final Task task;

  const UpdateTaskFetch({required this.task});
}
