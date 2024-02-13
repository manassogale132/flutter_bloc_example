part of 'post_bloc.dart';

// Events
abstract class PostEvent extends Equatable {}

class FetchPosts extends PostEvent {
  @override
  List<Object?> get props => [];
}

class AddPost extends PostEvent {
  final Post post;

  AddPost({required this.post});

  @override
  List<Object?> get props => [post];
}

class UpdatePost extends PostEvent {
  final Post post;

  UpdatePost({required this.post});

  @override
  List<Object?> get props => [post];
}

class DeletePost extends PostEvent {
  final int postId;

  DeletePost({required this.postId});

  @override
  List<Object?> get props => [postId];
}
