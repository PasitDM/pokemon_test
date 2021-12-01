// import 'package:flutter/material.dart';

// enum kSize { small, medium, large }

// class ImageTools {
//   /// Smart image function to load image cache and check empty URL to return empty box
//   /// Only apply for the product image resize with (small, medium, large)
//   static Widget image({
//     String? url,
//     kSize? size,
//     double? width,
//     double? height,
//     BoxFit? fit,
//     String? tag,
//     double offset = 0.0,
//     bool isResize = false,
//     bool? isVideo = false,
//     bool hidePlaceHolder = false,
//     bool forceWhiteBackground = false,
//   }) {
//     if (height == null && width == null) {
//       width = 200;
//     }
//     var ratioImage = kAdvanceConfig['RatioProductImage'] ?? 1.2;

//     if (url?.isEmpty ?? true) {
//       return FutureBuilder<bool>(
//         future: Future.delayed(const Duration(seconds: 10), () => false),
//         initialData: true,
//         builder: (context, snapshot) {
//           final showSkeleton = snapshot.data!;
//           return AnimatedSwitcher(
//             duration: const Duration(milliseconds: 500),
//             child: showSkeleton
//                 ? Skeleton(
//                     width: width!,
//                     height: height ?? width * ratioImage,
//                   )
//                 : SizedBox(
//                     width: width,
//                     height: height ?? width! * ratioImage,
//                     child: const Icon(Icons.error_outline),
//                   ),
//           );
//         },
//       );
//     }

//     if (isVideo!) {
//       return Stack(
//         children: <Widget>[
//           Container(
//             width: width,
//             height: height,
//             decoration: BoxDecoration(color: Colors.black12.withOpacity(1)),
//             child: ExtendedImage.network(
//               isResize ? formatImage(url, size)! : url!,
//               width: width,
//               height: height ?? width! * ratioImage,
//               fit: fit,
//               cache: true,
//               enableLoadState: false,
//               alignment: Alignment(
//                   (offset >= -1 && offset <= 1)
//                       ? offset
//                       : (offset > 0)
//                           ? 1.0
//                           : -1.0,
//                   0.0),
//             ),
//           ),
//           Positioned.fill(
//             child: Icon(
//               Icons.play_circle_outline,
//               color: Colors.white70.withOpacity(0.5),
//               size: width == null ? 30 : width / 1.7,
//             ),
//           ),
//         ],
//       );
//     }

//     if (kIsWeb) {
//       /// temporary fix on CavansKit https://github.com/flutter/flutter/issues/49725
//       var imageURL = isResize ? formatImage(url, size) : url;

//       return ConstrainedBox(
//         constraints: BoxConstraints(maxHeight: width! * ratioImage),
//         child: FadeInImage.memoryNetwork(
//           image: '$kImageProxy$imageURL',
//           fit: fit,
//           width: width,
//           height: height,
//           placeholder: kTransparentImage,
//         ),
//       );
//     }

//     final image = ExtendedImage.network(
//       isResize ? formatImage(url, size)! : url!,
//       width: width,
//       height: height,
//       fit: fit,
//       cache: true,
//       enableLoadState: false,
//       alignment: Alignment(
//         (offset >= -1 && offset <= 1)
//             ? offset
//             : (offset > 0)
//                 ? 1.0
//                 : -1.0,
//         0.0,
//       ),
//       loadStateChanged: (ExtendedImageState state) {
//         Widget? widget;
//         switch (state.extendedImageLoadState) {
//           case LoadState.loading:
//             widget = hidePlaceHolder
//                 ? const SizedBox()
//                 : Skeleton(
//                     width: width ?? 100,
//                     height: width != null
//                         ? width * ratioImage
//                         : 100 * ratioImage as double,
//                   );
//             break;
//           case LoadState.completed:
//             widget = ExtendedRawImage(
//               image: state.extendedImageInfo?.image,
//               width: width,
//               height: height,
//               fit: fit,
//             );
//             break;
//           case LoadState.failed:
//             widget = Container(
//               width: width,
//               height: height ?? width! * ratioImage,
//               color: const Color(kEmptyColor),
//             );
//             break;
//         }
//         return widget;
//       },
//     );

//     if (forceWhiteBackground && url!.toLowerCase().endsWith('.png')) {
//       return Container(
//         color: Colors.white,
//         child: image,
//       );
//     }

//     return image;
//   }
// }
