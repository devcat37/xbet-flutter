import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbet_1/internal/services/app_redirects.dart';
import 'package:xbet_1/internal/services/helpers.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/states/subscription_state/subscription_state.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';
import 'package:xbet_1/main.dart';

class SubscriptionPageView extends StatelessWidget {
  const SubscriptionPageView({Key? key}) : super(key: key);

  Widget _buildPlates(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => openTerms(),
                child: Text(
                  'Terms of Use',
                  style: TextStyle(fontSize: 12.w, fontWeight: FontWeight.w500, color: whiteColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  final res = await restore();
                  if (res) pop(context);
                },
                child: Text(
                  'Restore',
                  style: TextStyle(fontSize: 12.w, fontWeight: FontWeight.w500, color: whiteColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => openPrivacy(),
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 12.w, fontWeight: FontWeight.w500, color: whiteColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuyPremiumButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        final res = await purchase();
        if (res) pop(context);
      },
      borderRadius: borderRadius16,
      child: Ink(
        height: 56.h,
        width: MediaQuery.of(context).size.width - 2 * 16.w,
        decoration: BoxDecoration(
          borderRadius: borderRadius16,
          color: blueColor,
        ),
        child: Center(
          child: Text(
            'Buy premium for 0.99\$',
            style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: whiteColor),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => pop(context),
              child: const Icon(Icons.close, color: whiteColor),
            ),
          ),
          SizedBox(height: 16.h),
          Image.asset(
            'assets/images/subscription.png',
            width: MediaQuery.of(context).size.width,
          ),
          Text(
            'Ads removing'.toUpperCase(),
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 20.w, fontFamily: 'Montserrat'),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            'Option to add photos to your teams'.toUpperCase(),
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 20.w, fontFamily: 'Montserrat'),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            'Unlimited teams creating'.toUpperCase(),
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 20.w, fontFamily: 'Montserrat'),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          _buildBuyPremiumButton(context),
          SizedBox(height: 32.h),
          _buildPlates(context),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildContent(context),
      ),
    );
  }
}
