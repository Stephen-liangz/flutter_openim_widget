import 'package:flutter/material.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// typedef PopupMenuItemBuilder = Widget Function(PopMenuInfo info);

class PopMenuInfo {
  final String? icon;
  final String text;
  final Function()? onTap;

  PopMenuInfo({
    this.icon,
    required this.text,
    this.onTap,
  });
}

class PopButton extends StatelessWidget {
  final List<PopMenuInfo> menus;
  final Widget child;

  final CustomPopupMenuController? popCtrl;

  // final PopupMenuItemBuilder builder;
  final PressType pressType;
  final bool showArrow;
  final Color arrowColor;
  final Color barrierColor;
  final double horizontalMargin;
  final double verticalMargin;
  final double arrowSize;

  final Color menuBgColor;
  final double menuBgRadius;
  final Color? menuBgShadowColor;
  final Offset? menuBgShadowOffset;
  final double? menuBgShadowBlurRadius;
  final double? menuBgShadowSpreadRadius;

  final double? menuItemHeight;
  final double? menuItemWidth;
  final EdgeInsetsGeometry? menuItemPadding;
  final TextStyle menuItemTextStyle;
  final double menuItemIconSize;
  final Color dividingLineColor;
  final double dividingLineWidth;

  PopButton({
    Key? key,
    required this.menus,
    required this.child,
    // required this.builder,
    this.popCtrl,
    this.arrowColor = const Color(0xFF1B72EC),
    this.showArrow = true,
    this.barrierColor = Colors.transparent,
    this.arrowSize = 10.0,
    this.horizontalMargin = 16.0,
    this.verticalMargin = 0.0,
    this.pressType = PressType.singleClick,
    this.menuBgColor = const Color(0xFF1B72EC),
    this.menuBgRadius = 10.0,
    this.menuBgShadowColor,
    this.menuBgShadowOffset,
    this.menuBgShadowBlurRadius,
    this.menuBgShadowSpreadRadius,
    this.menuItemHeight,
    this.menuItemWidth,
    this.menuItemTextStyle = const TextStyle(
      fontSize: 15,
      color: Colors.white,
    ),
    this.menuItemIconSize = 20.0,
    this.menuItemPadding,
    this.dividingLineColor = const Color(0xFFF0F0F0),
    this.dividingLineWidth = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CopyCustomPopupMenu(
      controller: popCtrl,
      arrowColor: arrowColor,
      showArrow: showArrow,
      barrierColor: barrierColor,
      arrowSize: arrowSize,
      verticalMargin: verticalMargin,
      horizontalMargin: horizontalMargin,
      pressType: pressType,
      child: child,
      menuBuilder: () => _buildPopBgView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: menus.map((e) => _buildPopItemView(e)).toList(),
        ),
      ),
    );
  }

  _clickArea(double dy) {
    for (var i = 0; i < menus.length; i++) {
      if (dy > i * menuItemHeight! && dy <= (i + 1) * menuItemHeight!) {
        menus.elementAt(i).onTap?.call();
        popCtrl?.hideMenu();
      }
    }
  }

  Widget _buildPopBgView({Widget? child}) => Container(
        child: child,
        decoration: BoxDecoration(
          color: menuBgColor,
          borderRadius: BorderRadius.circular(menuBgRadius),
          boxShadow: [
            BoxShadow(
              color: menuBgShadowColor ?? Color(0xFF000000).withOpacity(0.5),
              offset: menuBgShadowOffset ?? Offset(0, 2),
              blurRadius: menuBgShadowBlurRadius ?? 6,
              spreadRadius: menuBgShadowSpreadRadius ?? 0,
            )
          ],
        ),
      );

  Widget _buildPopItemView(PopMenuInfo info) => GestureDetector(
        onTap: () {
          popCtrl?.hideMenu();
          info.onTap?.call();
        },
        behavior: HitTestBehavior.translucent,
        child: Container(
          height: menuItemHeight,
          width: menuItemWidth,
          padding: menuItemPadding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (null != info.icon)
                Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Image.asset(
                    info.icon!,
                    width: menuItemIconSize,
                    height: menuItemIconSize,
                  ),
                ),
              Text(
                info.text,
                style: menuItemTextStyle,
              ),
            ],
          ),
        ),
      );
}
