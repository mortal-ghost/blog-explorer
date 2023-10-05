import 'package:blog_explorer/services/database.dart';
import 'package:flutter/material.dart';
import '../models/blog.dart';
import 'blog_tile.dart';

Widget blogsList(List<Blog>? blogsStream, DataBase database) {
  return Container(
    child: blogsStream != null
        ? Column(
      children: <Widget>[
        Expanded(
          child: (blogsStream.isEmpty) ? (
              Container(
                alignment: Alignment.center,
                child: const Text("No blogs found"),
              )
          ) : ListView.builder(
            itemCount: blogsStream.length,
            itemBuilder: (context, index) {
              return BlogsTile(blog: blogsStream[index], database: database);
            },
          ),
        ),
      ],
    )
        : Container(
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    ),
  );
}