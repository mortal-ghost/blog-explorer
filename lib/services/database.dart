import 'package:blog_explorer/services/api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import '../models/blog.dart';

class DataBase extends ChangeNotifier {
  List<Blog>? _blogs;
  late Database db;
  
  List<Blog>? get blogs => _blogs;
  List<Blog> get favoriteBlogs => (_blogs != null) ? _blogs!.where((blog) => blog.isFavorite).toList() : [];

  DataBase() {
    _initializedDB();
    
    getBlogs().then((blogs) {
      _blogs = blogs;
      notifyListeners();
    });
  }

  Future<Database> _initializedDB() async {
    String path = await getDatabasesPath();

    db = await openDatabase(
      join(path, 'blog.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE blogs(id TEXT PRIMARY KEY, title TEXT, image_url TEXT)',
        );
        // A table to store favorite blogs, only store the id of the blog
        await database.execute(
          'CREATE TABLE favorite_blogs(id TEXT PRIMARY KEY)',
        );
      },
      version: 1,
    );
    
    return db;
  }

  Future<void> _insertBlog(Map<String, dynamic> blog) async {
    await db.insert('blogs', blog, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Blog>?> getBlogs() async {
    final response = await DataService().fetchBlogs();
    List<Blog> blogs;

    if (response != null) {
      blogs = [];
      for (var blog in response) {
        _insertBlog(blog);
        blogs.add(Blog.fromMap(blog));
      }
    } else {
      // Fetch from local database
      final blogsMap = await db.query('blogs');

      blogs = blogsMap.map((blog) => Blog.fromMap(blog)).toList();
    }

    if (blogs.isEmpty) {
      return null;
    }

    // Fetch the favorite blogs from local database
    List<String> favoriteBlogs = await _getFavoriteBlogIds();

    for (var blog in blogs) {
      if (favoriteBlogs.contains(blog.id)) {
        blog.isFavorite = true;
      }
    }

    return blogs;
  }

  Future<Blog> getBlog(String id) async {
    List<Map<String, dynamic>> blogs = await db.query('blogs', where: 'id = ?', whereArgs: [id]);

    return Blog.fromMap(blogs.first);
  }

  Future<int> addFavoriteBlog(String id) async {

    for (var blog in _blogs!) {
      if (blog.id == id) {
        blog.isFavorite = true;
        break;
      }
    }
    notifyListeners();
    return db.insert('favorite_blogs', {'id': id}, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> removeFavoriteBlog(String id) async {
    for (var blog in _blogs!) {
      if (blog.id == id) {
        blog.isFavorite = false;
        break;
      }
    }
    notifyListeners();
    return db.delete('favorite_blogs', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<String>> _getFavoriteBlogIds() async {
    List<Map<String, dynamic>> favouriteBlogIds= await db.query('favorite_blogs');

    List<String> ids = [];

    for (var blogId in favouriteBlogIds) {
      ids.add(blogId['id']);
    }

    return ids;
  }
}