import 'dart:io';

import 'package:aes_crypt/aes_crypt.dart';
import 'package:flutter/foundation.dart';



class ZcryptFfi {
 /*  int add(int a, int b) {
    return ffi.add(a, b);
  }

  int encrypt() {
    return ffi.encrypt();
  }
 */
  static Future<String> encryptFile(
      {@required String password,
      @required String path,
      bool overwrite = false}) async {
    String encFilepath;
    try {
      AesCrypt crypt = AesCrypt();
      crypt.setOverwriteMode(
          !overwrite ? AesCryptOwMode.rename : AesCryptOwMode.on);
      crypt.setPassword(password);
      encFilepath = crypt.encryptFileSync(path, path + ".zcrypt");
      /*  print('The encryption has been completed successfully.');
      print('Encrypted file: $encFilepath'); */
    } catch (e) {
      print(e.toString());
      if (e.type == AesCryptExceptionType.destFileExists) {
        print('The encryption has been completed unsuccessfully.');
        print(e.message);
      } else {
        return 'ERROR';
      }
    }
    return encFilepath;
  }

  static Future<String> decryptFile({
    @required String path,
    @required String finalPath,
    @required String password,
    bool overwrite = false,
  }) async {
    String decFilepath;
    try {
      AesCrypt crypt = AesCrypt();
      crypt.setOverwriteMode(
          !overwrite ? AesCryptOwMode.rename : AesCryptOwMode.on);
      crypt.setPassword(password);
      decFilepath = crypt.decryptFileSync(path, finalPath);
      /*    print('The decryption has been completed successfully.');
      print('Decrypted file 1: $decFilepath');
      print('File content: ' + File(decFilepath).path); */
    } catch (e) {
       print(e.toString());
      if (e.type == AesCryptExceptionType.destFileExists) {
        print('The decryption has been completed unsuccessfully.');
        print(e.message);
      } else {
        return 'ERROR';
      }
    }
    return decFilepath;
  }
}
