import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class FullScreenImage extends StatelessWidget {
  final AssetEntity e;
  const FullScreenImage(this.e, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: AssetEntityImage(
            e,
            fit: BoxFit.contain,
          ),
        ));
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(),
//     body: e.type == AssetType.image
//         ? SizedBox(
//             width: double.infinity,
//             height: double.infinity,
//             child: AssetEntityImage(
//               e,
//               isOriginal: true,
//               fit: BoxFit.contain,
//             ),
//           )
//         : SizedBox(
//             width: double.infinity,
//             height: double.infinity,
//             child: VideoPlayer(
//               VideoPlayerController.asset(),
//             ),
//           ),
//   );
// }
}
