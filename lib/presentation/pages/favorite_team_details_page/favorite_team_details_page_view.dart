import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xbet_1/domain/models/favorite_team/favorite_team.dart';
import 'package:xbet_1/internal/services/app_redirects.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';
import 'package:xbet_1/presentation/global/icons/bet_icons.dart';
import 'package:xbet_1/presentation/global/player_wrapper/player_wrapper.dart';

class FavoriteTeamDetailsPageView extends StatelessWidget {
  const FavoriteTeamDetailsPageView({
    Key? key,
    required this.team,
    required this.onDelete,
  }) : super(key: key);

  final FavoriteTeam team;
  final Function() onDelete;

  Widget _buildImage(BuildContext context) {
    if (team.image == null || (team.image?.isEmpty ?? false)) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Image.memory(
        Uint8List.fromList(team.image!),
        height: 120.r,
        width: 120.r,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16.h),
          _buildImage(context),
          ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: team.players.length,
            itemBuilder: (context, index) {
              return PlayerWrapper(
                player: team.players.elementAt(index),
              );
            },
            separatorBuilder: (_, __) => SizedBox(height: 12.h),
          ),
        ],
      ),
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return GestureDetector(
      onTap: () => showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: const Text('Delete this team'),
          content: const Text('Are you sure you want to delete this team?'),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () => pop(context),
            ),
            CupertinoDialogAction(
              child: const Text('Yes'),
              onPressed: () {
                onDelete();

                pop(context);
              },
            ),
          ],
        ),
      ),
      child: SvgPicture.asset(BetIcons.delete),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(team.title),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: _buildDeleteButton(context),
          ),
        ],
      ),
      body: _buildContent(context),
    );
  }
}
