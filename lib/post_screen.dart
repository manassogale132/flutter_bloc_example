import 'package:flutter/material.dart';
import 'package:flutter_application__bloc/bloc/post_bloc.dart';
import 'package:flutter_application__bloc/models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//Ui
class PostsScreenExample extends StatelessWidget {
  const PostsScreenExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Posts',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state is PostLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PostLoaded) {
            return ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final Post post = state.posts[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.amber.shade100,
                    leading: Text(
                      '$index',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    title: Text(post.title),
                    subtitle: post.description == null ||
                            post.description.toString().isEmpty
                        ? Text(post.title)
                        : Text(post.description.toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        BlocProvider.of<PostBloc>(context)
                            .add(DeletePost(postId: post.id));
                      },
                    ),
                  ),
                );
              },
            );
          } else if (state is PostError) {
            return const Center(child: Text('Failed to fetch posts'));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return _buildBottomSheet(
                context,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Builder(
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  final newPost = Post(
                    id: DateTime.now().millisecondsSinceEpoch,
                    title: titleController.text,
                    description: descriptionController.text,
                  );
                  BlocProvider.of<PostBloc>(context)
                      .add(AddPost(post: newPost));
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text('Add Post'),
              ),
            ],
          ),
        );
      },
    );
  }
}
