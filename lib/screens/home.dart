import 'package:blog_explorer/screens/favourites.dart';
import 'package:blog_explorer/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blog_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataBase>(
      builder: (context, database, _) => Scaffold(
        appBar: AppBar(
          title: const Text("Blog Explorer"),
          actions: [
            IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FavouriteBlogs()),
                );
              },
            ),
          ],
        ),
        body: blogsList(database.blogs, database),
      ),
    );
  }
}
