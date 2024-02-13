import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post extends Equatable {
  final int? albumId;
  final int id;
  final title;
  final description;
  String? url;
  String? thumbnailUrl;

  Post({
    this.albumId,
    required this.id,
    required this.title,
    required this.description,
    this.url,
    this.thumbnailUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        description: json['description'],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "description": description,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };

  @override
  List<Object?> get props =>
      [albumId, id, url, thumbnailUrl, title, description];

  Post copyWith({
    int? id,
    String? title,
    String? description,
    // Add other properties here
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      // Copy other properties here
    );
  }
}
