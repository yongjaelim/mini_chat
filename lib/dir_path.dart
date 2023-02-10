// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// class PhotoScreen extends StatefulWidget {
//   const PhotoScreen({Key? key}) : super(key: key);
//
//   @override
//   State<PhotoScreen> createState() => _PhotoScreenState();
// }
//
// class _PhotoScreenState extends State<PhotoScreen> {
//   Directory? directory;
//   final List<FileSystemEntity> _files = [];
//   Future<List<FileSystemEntity>> getAllFiles() async {
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       directory = Directory("/storage/emulated/0/DCIM/");
//     } else if (defaultTargetPlatform == TargetPlatform.iOS) {
//       //directory = Directory("/var/mobile/Media/Photos");
//       //directory = Directory("/var/mobile/Media/DCIM/100APPLE/");
//       directory = Directory("/private/var/mobile/Media/DCIM/100APPLE/");
//
//     }
//     List<FileSystemEntity> entities = directory!.listSync();
//     for (FileSystemEntity entity in entities) {
//       if (entity.path.endsWith(".jpg") || entity.path.endsWith(".jpeg") || entity.path.endsWith(".png") ||
//           entity.path.endsWith(".mp4") || entity.path.endsWith(".mov")) {
//         _files.add(entity);
//       }
//     }
//     return _files;
//   }
//
//   // Future<List<FileSystemEntity>> getAllFiles() async {
//   //   if (defaultTargetPlatform == TargetPlatform.android) {
//   //     directory = Directory("/storage/emulated/0/DCIM/");
//   //   } else if (defaultTargetPlatform == TargetPlatform.iOS) {
//   //     directory = Directory("/var/mobile/Media/Photos");
//   //     //directory = Directory("/var/mobile/Media/DCIM/100APPLE/");
//   //   }
//   //   List<FileSystemEntity> entities = directory!.listSync();
//   //   for (FileSystemEntity entity in entities) {
//   //     if (entity is Directory) {
//   //       print("Path: ${entity.path}");
//   //       List<FileSystemEntity> files = entity.listSync();
//   //       print("Files: $files");
//   //       for (FileSystemEntity file in files) {
//   //         if (file.path.endsWith(".jpg") || file.path.endsWith(".jpeg") || file.path.endsWith(".png") ||
//   //             file.path.endsWith(".mp4") || file.path.endsWith(".mov")) {
//   //           _files.add(file);
//   //         }
//   //       }
//   //     }
//   //   }
//   //   return _files;
//   // }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getAllFiles();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('photo'),
//         ));
//   }
// }
