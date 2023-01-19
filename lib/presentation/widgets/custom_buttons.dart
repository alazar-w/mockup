import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import '../../business/business.dart';

///Contains all the frequently used [Button]s for the app
class CustomButtons {
  CustomButtons._();

  ///Dark button
  static Widget primaryButton({
    required VoidCallback onPressed,
    required ThemeStyle themeStyle,
    required String text,
    double elevation = 10.0,
    double radius = 40.0,
    FontWeight fontWeight = FontWeight.bold,
    double? height,
    double? minWidth,
    EdgeInsets? padding,
    double? fontSize,
    Color? color,
    IconData? iconData,
    Color? textColor,
    String? svgPath,
    Color? iconColor,
    double? iconSize,
    double? svgHeight,
    double? svgWidth,
  }) {
    return MaterialButton(
        padding: padding ?? EdgeInsets.all(3.25.h),
        color: color ?? themeStyle.primaryColor,
        onPressed: onPressed,
        elevation: elevation,
        height: height,
        minWidth: minWidth ?? double.infinity,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            AutoSizeText(
              text,
              style: TextStyle(
                color: textColor ?? themeStyle.primaryColorOnPrimary,
                fontWeight: fontWeight,
              ),
              textAlign: TextAlign.center,
              maxFontSize: fontSize != null
                  ? fontSize.sp.floorToDouble()
                  : 10.sp.floorToDouble(),
              minFontSize: fontSize != null
                  ? (fontSize - 4).sp.floorToDouble()
                  : 7.sp.floorToDouble(),
            ),
          ],
        ));
  }

  ///Circular button used in app bar/tiles
  static Widget circularButton({
    VoidCallback? onPressed, // Not required if button is not interactive
    String? tooltip,
    String? svgPath,
    IconData? iconData,
    required Color backgroundColor,
    Color? iconColor,
    double? svgHeight,
    double? svgWidth,
    double? radius,
    double? iconSize,

    /// Padding around the whole button
    EdgeInsets? padding,
  }) {
    assert(svgPath != null || iconData != null);
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: CircleAvatar(
        radius: radius != null ? radius.h : 3.1.h,
        backgroundColor: backgroundColor,
        child: Material(
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: Tooltip(
            enableFeedback: onPressed != null,
            message: tooltip ?? '',
            child: InkResponse(
              radius: radius != null ? radius.h : 3.1.h,
              onTap: onPressed,
              child: svgPath == null
                  ? Icon(
                      iconData,
                      size: (iconSize ?? 3.25).h,
                      color: iconColor,
                    )
                  : SvgPicture.asset(
                      svgPath,
                      width: svgWidth != null ? svgWidth.h : 3.1.h,
                      height: svgHeight != null ? svgHeight.h : 3.1.h,
                      //color: iconColor,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
