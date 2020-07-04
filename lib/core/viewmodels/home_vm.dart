import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:process_run/process_run.dart';
import 'package:zcrypt_ffi/zcrypt_ffi.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:path/path.dart' as p;
import 'package:zcryptor/utils/margin.dart';

class HomeVM extends ChangeNotifier {
  final TextEditingController tec = new TextEditingController();

  FilePickerCross _filePicker = FilePickerCross();

  String encFilePath;
  String decFilePath;
  String filePath;

  String _password;
  String get password => _password;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isDone = false;
  bool get isDone => _isDone;

  bool _isEncryption = true;
  bool get isEncryption => _isEncryption;

  set password(String val) {
    _password = val;
    notifyListeners();
  }

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  set isDone(bool val) {
    _isDone = val;
    notifyListeners();
  }

  set isEncryption(bool val) {
    _isEncryption = val;
    notifyListeners();
  }

  void process() async {
    if (filePath != null || _filePicker.path.isNotEmpty)
      try {
        isLoading = true;
        notifyListeners();
        isDone = false;

        if (_isEncryption) {
          encFilePath = await ZcryptFfi.encryptFile(
            password: _password,
            overwrite: true,
            path: filePath,
          );
          notifyListeners();
        } else {
          decFilePath = await ZcryptFfi.decryptFile(
              password: _password,
              path: filePath,
              finalPath: filePath.replaceFirst('.zcrypt', ''));
          notifyListeners();
        }

        await open(_isEncryption ? encFilePath : decFilePath);
        _isDone = true;
        isLoading = false;
        notifyListeners();
      } catch (e) {
        isLoading = false;
        print(e.toString());
      }
  }

  pickFile() async {
    try {
      await _filePicker.pick();
      if (_filePicker.path != null || _filePicker.path.isNotEmpty) {
        reset();
        filePath = _filePicker.path;
      }
    } catch (e) {
    }
    notifyListeners();
  }

  reset() {
    encFilePath = "";
    decFilePath = "";
    filePath = "";
    isDone = false;
    notifyListeners();
  }

  open(String s) async {
    if (s != null)
      try {
        var spl = s.split(' ');

        var spx = spl.where((t) => t.isNotEmpty).toList();
        spx.removeWhere((t) => t == p.basename(s));

        await run(
          'open',
          spx,
        );
      } catch (e) {
        print(e.toString());
      }
  }

  showInfo(BuildContext context, info) {
    BotToast.showEnhancedWidget(
        clickClose: true,
        duration: Duration(seconds: 4),
        toastBuilder: (void Function() cancelFunc) {
          return Container(
            height: 90,
            width: context.screenWidth(),
            child: Material(
              color: Color(0xff2B2B2E),
            ),
          );
        });
  }
}
