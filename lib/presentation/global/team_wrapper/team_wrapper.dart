import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbet_1/domain/models/team/team.dart';
import 'package:xbet_1/internal/services/app_redirects.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';

class TeamWrapper extends StatelessWidget {
  const TeamWrapper({
    Key? key,
    required this.team,
    this.onPressed,
    this.pickedPlayers = false,
  }) : super(key: key);

  final Team team;
  final Function()? onPressed;

  final bool pickedPlayers;

  Widget _buildContent(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImage(imageUrl: team.image, height: 32.r),
        SizedBox(width: 12.w),
        Text(
          team.name,
          style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: pickedPlayers ? blueColor : whiteColor),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius16,
      onTap: () {
        if (onPressed != null) {
          onPressed!();
          return;
        }

        goToTeamDetailsPage(context, team: team);
      },
      child: Ink(
        height: 64.h,
        width: MediaQuery.of(context).size.width - 2 * 16.w,
        decoration: BoxDecoration(
          color: surfaceBlueColor,
          borderRadius: borderRadius16,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: _buildContent(context),
        ),
      ),
    );
  }
}
