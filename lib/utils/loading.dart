import 'package:flutter/material.dart';
import 'package:minpro_gani/dashboard.dart';
// import 'package:salles_tools/src/utils/hex_converter.dart';

void onLoading(BuildContext context) {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await showGeneralDialog(
        barrierColor: Colors.grey.withOpacity(0.3),
        context: context,
        barrierLabel: '',
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 1000),
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                title: Row(
                  children: const <Widget>[
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "Mohon tunggu ...",
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        pageBuilder: (context, animation1, animation2) {
          return const DashboardNavigation();
        });
  });
}
