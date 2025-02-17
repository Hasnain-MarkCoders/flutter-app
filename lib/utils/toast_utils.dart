import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'color_utils.dart';

class ToastUtils {
  static Timer? toastTimer;
  static OverlayEntry? _overlayEntry;

  static void showCustomToast(
      BuildContext context, String? message, String type) {
    if (toastTimer == null || !toastTimer!.isActive) {
      _overlayEntry = createOverlayEntry(context, message??'', type);
      Overlay.of(context)!.insert(_overlayEntry!);
      toastTimer = Timer(const Duration(seconds: 3), () {
        if (_overlayEntry != null) {
          _overlayEntry!.remove();
        }
      });
    }
  }

  static void showCustomToastWithTime(
      BuildContext context, String message, String type, int time) {
    if (toastTimer == null || !toastTimer!.isActive) {
      _overlayEntry = createOverlayEntry(context, message, type);
      Overlay.of(context)!.insert(_overlayEntry!);
      toastTimer = Timer(Duration(seconds: time), () {
        if (_overlayEntry != null) {
          _overlayEntry!.remove();
        }
      });
    }
  }

  static OverlayEntry createOverlayEntry(
      BuildContext context, String message, String type) {
    return OverlayEntry(
      builder: (context) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(top: 75.0, left: 25.0, right: 25.0,bottom: 30),
          padding:
          const EdgeInsets.only(left: 10.0, right: 25.0, top: 7.0, bottom: 7.0),
          decoration: BoxDecoration(
              // boxShadow: [Utils.boxShadow()],
              color: (type == 'warning')? AppColor.red:HexColor("#2D7033"),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                (type == 'warning') ? Icons.cancel : Icons.check_circle,
                color: Colors.white,
                size: 28.0,
              ),
              const SizedBox(
                width: 15.0,
              ),
              Expanded(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  maxLines: null,
                  style: const TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 12,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
