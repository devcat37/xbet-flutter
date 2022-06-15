import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/states/football_teams_state/football_teams_state.dart';
import 'package:xbet_1/presentation/global/logo_app_bar/logo_app_bar.dart';
import 'package:xbet_1/presentation/global/team_wrapper/team_wrapper.dart';

class FootballTeamsPageView extends StatelessWidget {
  const FootballTeamsPageView({Key? key}) : super(key: key);

  FootballTeamsState get state => service<FootballTeamsState>();

  Widget _buildContent(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.only(top: 16.h, bottom: 32.h, left: 16.w, right: 16.w),
      itemCount: state.teams.length,
      itemBuilder: (context, index) => TeamWrapper(team: state.teams.elementAt(index)),
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
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
