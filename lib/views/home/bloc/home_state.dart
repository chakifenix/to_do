part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<Task> tasksList;
  final bool taskAdded;
  final bool taskDeleted;

  const HomeState({
    this.status = HomeStatus.initial,
    this.tasksList = const [],
    this.taskAdded = false,
    this.taskDeleted = false,
  });

  @override
  List<Object?> get props => [
        status,
        tasksList,
        taskAdded,
        taskDeleted,
      ];

  bool get isInitial => status == HomeStatus.initial;
  bool get isLoading => status == HomeStatus.loading;
  bool get isSuccess => status == HomeStatus.success;
  bool get isFailure => status == HomeStatus.failure;

  HomeState copyWith({
    HomeStatus? status,
    List<Task>? tasksList,
    bool? taskAdded,
    bool? taskDeleted,
  }) {
    return HomeState(
      status: status ?? this.status,
      tasksList: tasksList ?? this.tasksList,
      taskAdded: taskAdded ?? this.taskAdded,
      taskDeleted: taskDeleted ?? this.taskDeleted,
    );
  }
}
