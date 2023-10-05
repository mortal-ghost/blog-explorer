import 'package:blog_explorer/screens/blog_details.dart';
import 'package:blog_explorer/services/database.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/blog.dart';

class BlogsTile extends StatefulWidget {
  final Blog blog;
  final DataBase database;
  const BlogsTile({super.key, required this.blog, required this.database});

  @override
  State<BlogsTile> createState() => _BlogsTileState();
}

class _BlogsTileState extends State<BlogsTile> {

  void handleFavorite() {
    if (widget.blog.isFavorite) {
      widget.database.removeFavoriteBlog(widget.blog.id);
    } else {
      widget.database.addFavoriteBlog(widget.blog.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      height: 200,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: widget.blog.imageUrl,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6)),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogDetails(blog: widget.blog),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.blog.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    icon: widget.blog.isFavorite
                        ? const Icon(Icons.favorite, color: Colors.red)
                        : const Icon(Icons.favorite_border),
                    onPressed: handleFavorite,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}