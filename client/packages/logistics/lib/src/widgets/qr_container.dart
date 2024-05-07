import 'package:flutter/material.dart';
import 'package:logistics/logistics.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrContainer extends StatelessWidget {
  final String data;
  final String? asset;
  final double? size, radius, assetSize;
  final Color? background, color;
  final EdgeInsetsGeometry? margin;
  const QrContainer(
      {Key? key,
      required this.data,
      this.size,
      this.radius,
      this.color,
      this.background,
      this.margin,
      this.asset,
      this.assetSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var box = size ?? 240;
    return Container(
      decoration: BoxDecoration(
          color: background ?? Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 20)),
      margin: margin,
      child: QrImage(
        data: data,
        eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.circle, color: color),
        foregroundColor: color,
        dataModuleStyle: QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.circle, color: color),
        version: QrVersions.auto,
        size: box,
        embeddedImage: asset != null ? AssetImage(asset!) : null,
        embeddedImageStyle: QrEmbeddedImageStyle(
          size: Size(assetSize ?? getProportionateScreenHeight(box * 0.08),
              assetSize ?? getProportionateScreenHeight(box * 0.04)),
        ),
      ),
    );
  }
}
