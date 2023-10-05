import 'package:blog_explorer/screens/blog_list.dart';
import 'package:blog_explorer/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class FavouriteBlogs extends StatefulWidget {
  const FavouriteBlogs({super.key});

  @override
  State<FavouriteBlogs> createState() => _FavouriteBlogsState();
}

class _FavouriteBlogsState extends State<FavouriteBlogs> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataBase>(
      builder: (context, database, _) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text("Favourite Blogs"),
        ),
        body: blogsList(database.favoriteBlogs, database),
      ),
    );
  }
}
