import 'package:apfp/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FFButtonOptions {
  const FFButtonOptions({
    this.textStyle,
    this.height,
    this.width,
    this.color,
    this.borderRadius,
    this.borderSide,
  });

  final TextStyle? textStyle;
  final double? height;
  final double? width;
  final Color? color;
  final double? borderRadius;
  final BorderSide? borderSide;
}

class FFButtonWidget extends StatelessWidget {
  const FFButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.options,
    this.loading = false,
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final FFButtonOptions options;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    Widget textWidget = loading
        ? Center(
            child: Container(
              width: 23,
              height: 23,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  options.textStyle!.color ?? Colors.white,
                ),
              ),
            ),
          )
        : AutoSizeText(
            text,
            style: options.textStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
    return Container(
      height: options.height,
      width: options.width,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(
                  FlutterFlowTheme.secondaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(options.borderRadius ?? 28),
                side: options.borderSide ?? BorderSide.none,
              ))),
          child: textWidget),
    );
  }
}
