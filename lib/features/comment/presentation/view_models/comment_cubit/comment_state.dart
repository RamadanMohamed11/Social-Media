part of 'comment_cubit.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class CommentLoading extends CommentState {}

final class CommentAddedSuccess extends CommentState {}

final class CommentAddFailure extends CommentState {
  final String message;
  CommentAddFailure({required this.message});
}
