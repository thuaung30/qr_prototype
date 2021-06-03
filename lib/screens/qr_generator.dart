import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_prototype/components/default_button.dart';
import 'package:screenshot/screenshot.dart';

class QRGenerator extends StatefulWidget {
  const QRGenerator({Key? key}) : super(key: key);

  @override
  _QRGeneratorState createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Screenshot(
          controller: screenshotController,
          child: Center(
            child: SizedBox(
              height: 310,
              width: 310,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/qr-border.jpg"),
                  ),
                ),
                child: QRCode(data: ""),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: DefaultButton(
            text: "Save to gallery",
            press: capture,
          ),
        ),
      ],
    ));
  }

  void capture() {
    screenshotController
        .capture(delay: Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      await ImageGallerySaver.saveImage(
        image!,
        quality: 100,
        name: "qr-test",
      );
    }).catchError((onError) {
      print(onError);
    });
  }
}

class QRCode extends StatelessWidget {
  const QRCode({Key? key, required this.data}) : super(key: key);
  final String data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImage(
        data: data,
        version: QrVersions.auto,
        size: 200.0,
        foregroundColor: Colors.orange,
      ),
    );
  }
}
