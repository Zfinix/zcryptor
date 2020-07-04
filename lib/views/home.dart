import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:zcryptor/core/viewmodels/home_vm.dart';
import 'package:zcryptor/utils/margin.dart';
import 'package:zcryptor/utils/theme.dart';

final pv = ChangeNotifierProvider((_) => HomeVM());

class Home extends StatefulHookWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(pv);
    return Scaffold(
      backgroundColor: black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const YMargin(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.isEncryption ? 'ENCRYPT' : 'DECRYPT',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: white,
                          fontSize: 10,
                          letterSpacing: 2.3),
                    )),
                Container(
                  height: 11,
                  child: Switch(
                    inactiveTrackColor: Color(0xFF262626),
                    inactiveThumbColor: Color(0xFF343434),
                    activeColor: Color(0XFF0EDB55),
                    onChanged: (bool value) =>
                        provider.isEncryption = !provider.isEncryption,
                    value: provider.isEncryption,
                  ),
                )
              ],
            ),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                GestureDetector(
                    onTap: () {
                      provider.pickFile();
                    },
                    child: provider.isEncryption ? NormalFile() : EncFile()),
                Spacer(),
                Container(
                  width: context.screenWidth(0.5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (provider.isDone || provider.isLoading)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 3,
                            child: LinearProgressIndicator(
                              value: provider.isLoading ? null : 1,
                              backgroundColor: Color(0xFF262626),
                              valueColor:
                                  AlwaysStoppedAnimation(Color(0XFF0EDB55)),
                            ),
                          ),
                        ),
                      if (!provider.isDone && !provider.isLoading)
                        Column(
                          children: [
                            TextField(
                              controller: provider.tec,
                              autofocus: true,
                              style: GoogleFonts.sourceCodePro(
                                color: white,
                                fontSize: 14,
                                fontWeight: FontWeight.w200,
                              ),
                              onChanged: (s) {
                                provider.password = s;
                              },
                              textAlign: TextAlign.center,
                              cursorColor: white,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText:
                                    'ENTER PASSWORD TO ${provider.isEncryption ? 'EN' : 'DE'}CRYPT',
                                hintStyle: GoogleFonts.sourceCodePro(
                                  color: white.withOpacity(0.4),
                                  fontWeight: FontWeight.w200,
                                  fontSize: 11,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                            const YMargin(30),
                            FlatButton(
                              color: Color(0XFF0EDB55),
                              onPressed: () {
                                provider.process();
                              },
                              child: Text('PROCESS',
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: white,
                                        fontSize: 7,
                                        letterSpacing: 1),
                                  )),
                            )
                          ],
                        ),
                      const YMargin(30),
                    ],
                  ),
                ),
                Spacer(),
                provider.isEncryption ? EncFile() : NormalFile(),
                Spacer(),
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class EncFile extends HookWidget {
  const EncFile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(pv);
    return AnimatedOpacity(
      opacity:
          !provider.isEncryption ? provider.filePath != null ? 1 : 0.5 : 0.5,
      duration: Duration(milliseconds: 400),
      child: Container(
        width: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/enc_file.png',
              scale: 4,
            ),
            const YMargin(30),
            provider.isEncryption
                ? Text(
                    (provider.encFilePath != null
                            ? p.basename(provider.encFilePath)
                            : "")
                        .toUpperCase(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: white,
                          fontSize: 8,
                          height: 1.5,
                          letterSpacing: 1.5),
                    ))
                : Text(
                    (provider.filePath != null
                            ? p.basename(provider.filePath)
                            : "CHOOSE FILE")
                        .toUpperCase(), overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: white,
                          fontSize: 8,
                          height: 1.5,
                          letterSpacing: 1.5),
                    )),
          ],
        ),
      ),
    );
  }
}

class NormalFile extends HookWidget {
  const NormalFile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(pv);
    return AnimatedOpacity(
      opacity:
          provider.isEncryption ? provider.filePath != null ? 1 : 0.5 : 0.5,
      duration: Duration(milliseconds: 400),
      child: Container(
        width: 90,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/file.png',
              scale: 4,
            ),
            const YMargin(30),
            !provider.isEncryption
                ? Text(
                    (provider.decFilePath != null
                            ? p.basename(provider.decFilePath)
                            : "")
                        .toUpperCase(),
                         overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: white,
                          height: 1.5,
                          fontSize: 8,
                          letterSpacing: 1.5),
                    ))
                : Text(
                    (provider.filePath != null
                            ? p.basename(provider.filePath)
                            : "")
                        .toUpperCase(),
                         overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: white,
                          height: 1.5,
                          fontSize: 8,
                          letterSpacing: 1.5),
                    )),
          ],
        ),
      ),
    );
  }
}
