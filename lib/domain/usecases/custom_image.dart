import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:stockaxis/core/constants/app_constants.dart';
import '../../generated/assets.dart';

class CustomImage extends StatelessWidget {
  final String path;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final String? placeholder;
  final String? onError;
  final Color? color;
  final Alignment? alignment;
  final Function()? onTap;
  final bool viewFullScreen;
  final double radius;

  const CustomImage({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.fit,
    this.placeholder,
    this.color,
    this.onError,
    this.alignment,
    this.onTap,
    this.radius = 0,
    this.viewFullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    // Tap handler for the image
    void _handleTap() {
      if (onTap != null) onTap!();
      // Uncomment to enable full screen view
      // if (viewFullScreen) {
      //   Navigator.push(context, getCustomRoute(child: ImageGallery(images: [path])));
      // }
    }

    // Function to build the image widget based on path type
    Widget _buildImage() {
      // If path is a local asset
      if (path.startsWith('assets/')) {
        return _CustomAssetImage(
          path: path,
          fit: fit,
          height: height,
          width: width,
          color: color,
          alignment: alignment,
        );
      }

      // If path is a URL
      String url = path.replaceAll('\\', '/');
      if (!url.startsWith('http')) url = AppConstants.getBaseUrl + url;

      return CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: fit,
        placeholderFadeInDuration: const Duration(seconds: 1),
        alignment: alignment ?? Alignment.center,
        placeholder: (context, imageUrl) => Center(
          child: Transform.scale(
            scale: placeholder != null ? 0.75 : 1,
            child: Image.asset(
              placeholder ?? Assets.gifsShimmer,
              height: height,
              width: width,
              fit: fit,
            ),
          ),
        ),
        errorWidget: (context, imageUrl, stackTrace) => Image.asset(
          onError ?? Assets.imagesPlaceholder,
          height: height,
          width: width,
          fit: fit,
          color: color,
        ),
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(radius),
      onTap: (onTap != null || viewFullScreen) ? _handleTap : null,
      child: Ink(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: _buildImage(),
        ),
      ),
    );
  }
}

class _CustomAssetImage extends StatelessWidget {
  const _CustomAssetImage({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.alignment,
  });

  final String path;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      fit: fit,
      height: height,
      width: width,
      color: color,
      alignment: alignment ?? Alignment.center,
    );
  }
}
