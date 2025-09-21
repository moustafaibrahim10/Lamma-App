import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/styles/icon_broken.dart';

import '../../utils/app_constants.dart';
import '../../utils/enums.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required String labelText,
  required IconData icon,
  required String? validate(String)?,
  String? submited(String)?,
  TextInputType? keyboardType = TextInputType.text,
  Widget? suffixIcon,
  bool? obscureText = false,
}) => TextFormField(
  controller: controller,
  cursorColor: AppConstants.primaryColor,
  obscureText: obscureText!,
  keyboardType:keyboardType ,
  decoration: InputDecoration(
    prefixIcon: Icon(icon,color: Colors.grey,),
    suffixIcon: suffixIcon,
    labelText: labelText,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppConstants.primaryColor),
      borderRadius: BorderRadius.circular(10),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent),
      borderRadius: BorderRadius.circular(10),
    ),
    floatingLabelStyle: TextStyle(color: AppConstants.primaryColor),
  ),
  onFieldSubmitted: submited,
  validator: validate,
);

Widget defaultElevatedButton({
  required BuildContext context,
  required String text,
  double? height,
  double? width,
  double? radius,
  double? textSize,
  required Function() function,
}) => SizedBox(
  height: height,
  width: width,
  child: ElevatedButton(
    onPressed: function,
    child: Text(
      text,
      style: TextStyle(color: Colors.white, fontSize: textSize ?? 20),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: AppConstants.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 5),
      ),
    ),
  ),
);

Future<bool?> showToast({required String msg, required ToastState state}) =>
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: _chooseToastColor(state: state),
      toastLength: Toast.LENGTH_SHORT,
      textColor: Colors.white,
      timeInSecForIosWeb: 5,
    );

Color _chooseToastColor({required ToastState state}) {
  switch (state) {
    case ToastState.success:
      return Colors.blue;
    case ToastState.warring:
      return Colors.yellow;
    case ToastState.error:
      return Colors.red;
  }
}

Future pushAndFinish({required BuildContext context, required Widget screen}) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );

Widget defaultTextbutton({
  required String text,
  required Function() function,
}) => TextButton(
  onPressed: function,
  child: Text(
    text,
    style: TextStyle(
      color: AppConstants.primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
);

Widget myDivider() =>
    Container(width: double.infinity, height: 1.0, color: Colors.grey[300]);

Future<dynamic> navigateTo(BuildContext context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

//AppBar
PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: () {
      Navigator.pop(context);
    },
    icon: Icon(IconBroken.Arrow___Left_2,color: Colors.grey,),
  ),
  titleSpacing: 3.0,
  title: title != null && title.isNotEmpty ? Text(title,style: Theme.of(context).textTheme.headlineSmall,) : null,
  actions: actions,
);
