import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xbet_1/internal/services/app_redirects.dart';
import 'package:xbet_1/internal/services/helpers.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/states/subscription_state/subscription_state.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';
import 'package:xbet_1/presentation/global/icons/bet_icons.dart';
import 'package:xbet_1/presentation/global/logo_app_bar/logo_app_bar.dart';

class SettingsPageView extends StatelessWidget {
  const SettingsPageView({Key? key}) : super(key: key);

  Widget _buildButton(BuildContext context,
      {required String image, required String title, required Function() onPressed}) {
    return InkWell(
      borderRadius: borderRadius16,
      onTap: onPressed,
      child: Ink(
        height: 87.h,
        width: MediaQuery.of(context).size.width - 2 * 16.w,
        decoration: BoxDecoration(
          color: surfaceBlueColor,
          borderRadius: borderRadius16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image),
            SizedBox(height: 12.h),
            Text(
              title,
              style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: whiteColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          if (!service<SubscriptionState>().isSubscribed) ...[
            _buildButton(
              context,
              image: BetIcons.premium,
              title: 'Premium',
              onPressed: () => goToSubscriptionPage(context),
            ),
            SizedBox(height: 12.w),
          ],
          GridView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.w,
              mainAxisExtent: 87.h,
            ),
            children: [
              _buildButton(context, image: BetIcons.privacy, title: 'Privacy Policy', onPressed: () {}),
              _buildButton(context, image: BetIcons.terms, title: 'Terms of Use', onPressed: () {}),
              _buildButton(
                context,
                image: BetIcons.rate,
                title: 'Rate app',
                onPressed: () => rateMyApp.showRateDialog(context),
              ),
              _buildButton(context, image: BetIcons.support, title: 'Support', onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LogoAppBar(),
      body: _buildContent(context),
    );
  }
}
