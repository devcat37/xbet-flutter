import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbet_1/internal/services/app_redirects.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/states/subscription_state/subscription_state.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';

class SubscriptionPageView extends StatelessWidget {
  const SubscriptionPageView({Key? key}) : super(key: key);

  Widget _buildBuyPremiumButton(BuildContext context) {
    return InkWell(
      onTap: () {
        service<SubscriptionState>().isSubscribed = true;
        pop(context);
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
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 20.w),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            'Option to add photos to your teams'.toUpperCase(),
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 20.w),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          Text(
            'Unlimited teams creating'.toUpperCase(),
            style: TextStyle(color: whiteColor, fontWeight: FontWeight.bold, fontSize: 20.w),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          _buildBuyPremiumButton(context),
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
