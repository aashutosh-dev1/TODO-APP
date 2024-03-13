/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsLocationsGen {
  const $AssetsLocationsGen();

  /// File path: assets/locations/bhaktapur.jpeg
  AssetGenImage get bhaktapur =>
      const AssetGenImage('assets/locations/bhaktapur.jpeg');

  /// File path: assets/locations/kathmandu.jpeg
  AssetGenImage get kathmandu =>
      const AssetGenImage('assets/locations/kathmandu.jpeg');

  /// File path: assets/locations/lalitpur.jpeg
  AssetGenImage get lalitpur =>
      const AssetGenImage('assets/locations/lalitpur.jpeg');

  /// List of all assets
  List<AssetGenImage> get values => [bhaktapur, kathmandu, lalitpur];
}

class $AssetsPropertyTypesGen {
  const $AssetsPropertyTypesGen();

  /// File path: assets/property_types/apartment.png
  AssetGenImage get apartment =>
      const AssetGenImage('assets/property_types/apartment.png');

  /// File path: assets/property_types/flat.jpeg
  AssetGenImage get flat =>
      const AssetGenImage('assets/property_types/flat.jpeg');

  /// File path: assets/property_types/office.jpeg
  AssetGenImage get office =>
      const AssetGenImage('assets/property_types/office.jpeg');

  /// File path: assets/property_types/room.jpeg
  AssetGenImage get room =>
      const AssetGenImage('assets/property_types/room.jpeg');

  /// List of all assets
  List<AssetGenImage> get values => [apartment, flat, office, room];
}

class Assets {
  Assets._();

  static const $AssetsLocationsGen locations = $AssetsLocationsGen();
  static const $AssetsPropertyTypesGen propertyTypes =
      $AssetsPropertyTypesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
