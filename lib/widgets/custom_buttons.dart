import 'package:egg_timer/utils/screen_utils/size_config.dart';
import 'package:egg_timer/utils/screen_utils/text_themes.dart';
import 'package:egg_timer/utils/screen_utils/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final Function() onTap;

  const CustomButton({required this.onTap, required this.buttonIcon, required this.buttonText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: SizedBox(
        height: 80.vdp(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ExpSized(),
            Icon(
              buttonIcon,
            ),
            Text(
              buttonText,
              style: AppTextThemes().headline2,
            ),
            const ExpSized(),
          ],
        ),
      ),

      // style: TextButton.styleFrom(
      //   backgroundColor: Colors.red,
      // ),
      // icon: Icon(buttonIcon),
      // label: Text(
      //   buttonText,
      //   style: AppTextThemes().headline2,
      // ),
    );
  }

  // GestureDetector buildGestureDetector() {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Row(
  //       mainAxisSize: MainAxisSize.max,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         const ExpSized(),
  //         Icon(
  //           buttonIcon,
  //         ),
  //         Text(
  //           buttonText,
  //           style: AppTextThemes().headline2,
  //         ),
  //         const ExpSized(),
  //       ],
  //     ),
  //   );
  // }

}
