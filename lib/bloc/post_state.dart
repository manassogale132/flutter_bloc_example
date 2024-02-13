part of 'post_bloc.dart';

//State
abstract class PostState extends Equatable {}

class PostInitial extends PostState {
  @override
  List<Object?> get props => [];
}

class PostLoading extends PostState {
  @override
  List<Object?> get props => [];
}

class PostLoaded extends PostState {
  final List<Post> posts;

  PostLoaded({required this.posts});

  @override
  List<Object?> get props => [posts];

  @override
  String toString() => 'PostLoaded(posts: $posts)';
}

class PostError extends PostState {
  @override
  List<Object?> get props => [];
}
