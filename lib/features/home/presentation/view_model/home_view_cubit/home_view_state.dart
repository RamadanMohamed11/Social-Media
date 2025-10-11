part of 'home_view_cubit.dart';

@immutable
sealed class HomeViewState {}

final class HomeViewInitial extends HomeViewState {}

final class HomeViewLoading extends HomeViewState {}

final class HomeViewSuccess extends HomeViewState {}

final class HomeViewError extends HomeViewState {
  final String errorMessage;
  HomeViewError(this.errorMessage);
}
