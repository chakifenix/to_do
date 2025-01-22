import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:to_do/data/task_storage.dart';
import 'package:to_do/models/task.dart';

part 'home_events.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<LoadTasksFetch>(_loadTasksFetch);
    on<AddNewTaskFetch>(_addNewTaskFetch);
    on<DeleteTaskFetch>(_deleteTaskFetch);
    on<UpdateTaskFetch>(_updateTaskFetch);
  }

  void _loadTasksFetch(LoadTasksFetch event, Emitter<HomeState> emit) async {
    final tasks = await TaskStorage.loadTasks();
    emit(state.copyWith(tasksList: tasks));
  }

  void _addNewTaskFetch(AddNewTaskFetch event, Emitter<HomeState> emit) async {
    emit(state.copyWith(taskAdded: false));
    await TaskStorage.addTask(event.task);
    emit(state.copyWith(taskAdded: true));
  }

  void _deleteTaskFetch(DeleteTaskFetch event, Emitter<HomeState> emit) async {
    await TaskStorage.deleteTask(event.id);
    emit(state.copyWith(taskDeleted: true));
  }

  void _updateTaskFetch(UpdateTaskFetch event, Emitter<HomeState> emit) async {
    await TaskStorage.updateTask(event.task);
    final tasks = await TaskStorage.loadTasks();
    emit(state.copyWith(tasksList: tasks));
  }
}
