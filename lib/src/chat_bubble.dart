import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum BubbleType {
  send,
  receiver,
}

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    Key? key,
    this.constraints,
    this.backgroundColor,
    this.child,
    required this.bubbleType,
  }) : super(key: key);
  final BoxConstraints? constraints;
  final Color? backgroundColor;
  final Widget? child;
  final BubbleType bubbleType;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      margin: EdgeInsets.only(right: 8.w, left: 0.w, ),
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(3.r)),
      ),
      child: child,
    );
  }
}
