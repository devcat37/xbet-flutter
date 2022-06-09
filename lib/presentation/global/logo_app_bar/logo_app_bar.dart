import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';
import 'package:xbet_1/presentation/global/icons/bet_icons.dart';

class LogoAppBar extends StatefulWidget implements PreferredSizeWidget {
  const LogoAppBar({Key? key}) : super(key: key);

  @override
  State<LogoAppBar> createState() => _LogoAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _LogoAppBarState extends State<LogoAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: SvgPicture.asset(BetIcons.logo, height: 40.h),
        ),
      ),
    );
  }
}
