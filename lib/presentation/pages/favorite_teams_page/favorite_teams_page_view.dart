import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbet_1/internal/services/app_redirects.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/states/favorite_teams_state/favorite_teams_state.dart';
import 'package:xbet_1/internal/states/subscription_state/subscription_state.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';
import 'package:xbet_1/presentation/global/favorite_team_wrapper/favorite_team_wrapper.dart';
import 'package:xbet_1/presentation/global/logo_app_bar/logo_app_bar.dart';

class FavoriteTeamsPageView extends StatelessWidget {
  const FavoriteTeamsPageView({Key? key}) : super(key: key);

  FavoriteTeamsState get favoriteTeamsState => service<FavoriteTeamsState>();
  SubscriptionState get subscriptionState => service<SubscriptionState>();

  Widget _buildCreateTeamButton(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!subscriptionState.isSubscribed && favoriteTeamsState.teams.length >= 3) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('You can’t create more than 3 teams'),
              content: const Text('Delete existing team or buy premium'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Cancel'),
                  onPressed: () => pop(context),
                ),
                CupertinoDialogAction(
                  child: const Text('Buy'),
                  onPressed: () => pop(context),
                ),
              ],
            ),
          );
        } else {
          goToCreateTeamPage(context);
        }
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
            'Create your dream team',
            style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: whiteColor),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyTeams(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sidePadding16.w),
            child: Text(
              'Right now you don\'t have any teams\nCreate one by clicking on the button below',
              style: TextStyle(color: whiteColor.withOpacity(0.4), fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
          Image.asset(
            'assets/images/football.png',
            width: MediaQuery.of(context).size.width,
          ),
          const Spacer(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildTeams(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: favoriteTeamsState.teams.length,
      itemBuilder: (context, index) => FavoriteTeamWrapper(
        onDelete: () {
          favoriteTeamsState.deleteTeam(favoriteTeamsState.teams.elementAt(index));
          pop(context);
        },
        team: favoriteTeamsState.teams.elementAt(index),
      ),
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Observer(builder: (context) {
      if (favoriteTeamsState.teams.isEmpty) {
        return _buildEmptyTeams(context);
      } else {
        return _buildTeams(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LogoAppBar(),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            _buildContent(context),
            Positioned(
              bottom: 16.h,
              left: 16.w,
              right: 16.w,
              child: _buildCreateTeamButton(context),
            ),
          ],
        ),
      ),
    );
  }
}
