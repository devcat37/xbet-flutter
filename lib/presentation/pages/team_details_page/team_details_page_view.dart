import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbet_1/domain/models/player/player.dart';
import 'package:xbet_1/domain/models/team/team.dart';
import 'package:xbet_1/internal/services/helpers.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';
import 'package:xbet_1/presentation/global/player_wrapper/player_wrapper.dart';

class TeamDetailsPageView extends StatelessWidget {
  const TeamDetailsPageView({
    Key? key,
    required this.team,
    required this.players,
  }) : super(key: key);

  final Team team;
  final List<Player> players;

  Widget _buildChar(BuildContext context, {required String title, required int value}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 12.w, fontWeight: FontWeight.w500, color: whiteColor),
          ),
          SizedBox(height: 8.h),
          Text(
            value.toString(),
            style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: whiteColor),
          ),
        ],
      ),
    );
  }

  Widget _buildStandings(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            'Standings',
            style: TextStyle(fontSize: 20.w, fontWeight: FontWeight.bold, color: whiteColor),
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              _buildChar(context, title: 'Played', value: team.played),
              _buildChar(context, title: 'Won', value: team.won),
              _buildChar(context, title: 'Draws', value: team.draws),
              _buildChar(context, title: 'Lost', value: team.lost),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Points: ${team.points}',
            style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: whiteColor),
          ),
        ),
      ],
    );
  }

  Widget _buildSquad(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            'Squad',
            style: TextStyle(fontSize: 20.w, fontWeight: FontWeight.bold, color: whiteColor),
          ),
        ),
        SizedBox(height: 16.h),
        ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: players.length,
          itemBuilder: (context, index) {
            return PlayerWrapper(
              player: players.elementAt(index),
            );
          },
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
        ),
      ],
    );
  }

  Widget _buildTeamInformation(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        height: 80.r,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: team.image,
              height: 80.r,
              width: 80.r,
              fit: BoxFit.contain,
              errorWidget: (_, __, ___) => SizedBox(height: 80.r, width: 80.r),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  team.name,
                  style: TextStyle(fontSize: 20.w, fontWeight: FontWeight.bold, color: whiteColor),
                ),
                SizedBox(height: 8.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 24.r,
                      width: 24.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1.0, color: Colors.grey),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('https://flagcdn.com/w20/${countryCodeFromCountry(team.country)}.png'),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      team.country.substring(0, 3).toUpperCase(),
                      style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: whiteColor.withOpacity(0.4)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          _buildTeamInformation(context),
          SizedBox(height: 24.h),
          _buildStandings(context),
          SizedBox(height: 24.h),
          _buildSquad(context),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: _buildContent(context),
      ),
    );
  }
}
