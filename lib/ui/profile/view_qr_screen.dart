import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../utils/export_files.dart';

class ViewQrScreen extends StatelessWidget {

  const ViewQrScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: QrImageView(
          data: 'https://knot-krazy.web.app/',
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
