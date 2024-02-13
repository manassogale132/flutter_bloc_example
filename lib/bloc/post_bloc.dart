import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application__bloc/models/post.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

part 'post_event.dart';
part 'post_state.dart';

//Bloc
class PostBloc extends Bloc<PostEvent, PostState> {
  List<Post> _posts = [];

  PostBloc() : super(PostInitial()) {
    on<FetchPosts>(_fetchPosts);
    on<AddPost>(_addPost);
    on<UpdatePost>(_updatePost);
    on<DeletePost>(_deletePost);
  }

  Future<void> _fetchPosts(FetchPosts event, Emitter<PostState> emit) async {
    emit(PostLoading());
    try {
      _posts = await getPosts();
      emit(PostLoaded(posts: _posts));
    } catch (e) {
      emit(PostError());
    }
  }

  // Future<void> _fetchPosts(FetchPosts event, Emitter<PostState> emit) async {
  //   // Simulating fetching from API, you can also directly set the list here
  //   _posts = _generatePosts(); // Generate local posts
  //   emit(PostLoaded(posts: _posts));
  // }

  void _addPost(AddPost event, Emitter<PostState> emit) {
    // if (_posts.length < 10) {
    //   final List<Post> updatedPosts = List.from(_posts)
    //     ..add(event.post); // Create a new list with added post
    //   _posts = updatedPosts; // Update _posts list
    //   emit(PostLoaded(posts: _posts));
    // }

    if (_posts.length < 10) {
      // int newId = _posts.isEmpty ? 1 : _posts.last.id + 1;
      // final Post newPost = event.post.copyWith(id: newId);
      final List<Post> updatedPosts = List.from(_posts)
        ..add(event.post); // Create a new list with added post
      _posts = updatedPosts; // Update _posts list
      emit(PostLoaded(posts: _posts));
    }
  }

  void _updatePost(UpdatePost event, Emitter<PostState> emit) {
    final index = _posts.indexWhere((post) => post.id == event.post.id);
    if (index != -1) {
      _posts[index] = event.post;
      emit(PostLoaded(posts: _posts));
    }
  }

  void _deletePost(DeletePost event, Emitter<PostState> emit) {
    _posts = _posts
        .where((post) => post.id != event.postId)
        .toList(); // Update _posts list
    emit(PostLoaded(posts: _posts));
  }

  //Api List
  Future<List<Post>> getPosts() async {
    var url = 'https://jsonplaceholder.typicode.com/photos';
    List<Post> result = [];

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        result = postFromJson(response.body);
      } else {
        print('Something went wrong!');
      }
    } catch (exception) {}
    return result.take(10).toList();
  }

  //Local List
  // List<Post> _generatePosts() {
  //   // Generate your list of posts here, you can manually create them or use any other method
  //   return List.generate(15, (index) {
  //     return Post(id: index + 1, title: 'Post ${index + 1}');
  //   });
  // }

  // @override
  // void onChange(Change<PostState> change) {
  //   super.onChange(change);
  //   log('---------onChange---------');
  //   log(change.nextState.toString());
  // }

  // @override
  // void onTransition(Transition<PostEvent, PostState> transition) {
  //   super.onTransition(transition);
  //   log('---------transition---------');
  //   log(transition.nextState.toString());
  // }
}
