import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hello/main.dart';
import 'package:flutter/services.dart';

const PRODUCTS_JSON = 'https://slickdaddy-3c63c.firebaseapp.com/jojos.json';

class BlogHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new BlogHomeState();
}

class BlogHomeState extends State<BlogHome> {
  List<BlogPost> posts = new List();

  final http = createHttpClient();

  @override
  void initState() {
    super.initState();
    http.read(PRODUCTS_JSON).then((response) {
      var converted = JSON.decode(response);
      final p = converted['posts'] as List<Map<String, Object>>;
      setState(() {
        posts = p.map((m) => new BlogPost.fromJSON(m)).toList();
      });
    });
  }

  _buildPost(BuildContext context, int i) {
    final post = posts[i];
    print(post.title);
    return new ListTile(
      onTap: () => launchURL(post.url, forceWebView: true),
      title: new Text(post.title),
      trailing: new FadeInImage.assetNetwork(
        placeholder: 'images/placeholder.jpg',
        image: post.imageUrl,
        width: 76.0,
        height: 76.0,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: _buildPost,
      itemCount: posts.length,
    );
  }
}

class BlogPost {
  final String title;
  final String url;
  final String imageUrl;
  final String description;

  const BlogPost({this.title, this.url, this.imageUrl, this.description});

  BlogPost.fromJSON(Map<String, Object> json)
      : title = json['title'] as String,
        url = json['url'] as String,
        imageUrl = json['imageUrl'] as String,
        description = json['description'] as String;
}
