import 'package:mini_chat/dir_path.dart';
import 'package:mini_chat/photo_screen.dart';
import 'package:flutter/material.dart';
import 'package:mini_chat/view_models/full_screen_image_view_model.dart';
import 'package:mini_chat/view_models/full_screen_video_view_model.dart';
import 'package:mini_chat/view_models/image_view_model.dart';
import 'package:mini_chat/views/image_view.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int start = 0;
  int end = 19;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ImageViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FullScreenVideoViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => FullScreenImageViewModel(),
        ),
      ],
      child: const MaterialApp(
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: onPhotoClick,
              icon: const Icon(Icons.collections),
            ),
          ],
        ),
      ),
    );
  }

  void onPhotoClick() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ImageView()),
    );
  }
}
