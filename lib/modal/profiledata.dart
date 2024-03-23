// To parse this JSON data, do
//
//     final profileData = profileDataFromJson(jsonString);

import 'dart:convert';

ProfileData profileDataFromJson(String str) =>
    ProfileData.fromJson(json.decode(str));

String profileDataToJson(ProfileData data) => json.encode(data.toJson());

class ProfileData {
  final String bio;
  final int followers;
  final int following;
  final String fullName;
  final Map<String, Image> images;
  final int posts;
  final String username;

  ProfileData({
    required this.bio,
    required this.followers,
    required this.following,
    required this.fullName,
    required this.images,
    required this.posts,
    required this.username,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        bio: json["bio"],
        followers: json["followers"],
        following: json["following"],
        fullName: json["full_name"],
        images: Map.from(json["images"])
            .map((k, v) => MapEntry<String, Image>(k, Image.fromJson(v))),
        posts: json["posts"],
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "bio": bio,
        "followers": followers,
        "following": following,
        "full_name": fullName,
        "images": Map.from(images)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "posts": posts,
        "username": username,
      };
}

class Image {
  final String discription;
  final int likes;
  final String url;

  Image({
    required this.discription,
    required this.likes,
    required this.url,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        discription: json["discription"],
        likes: json["likes"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "discription": discription,
        "likes": likes,
        "url": url,
      };
}
