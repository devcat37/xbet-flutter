import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbet_1/domain/models/favorite_team/favorite_team.dart';
import 'package:xbet_1/internal/services/app_redirects.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';
import 'package:xbet_1/presentation/pages/favorite_team_details_page/favorite_team_details_page_view.dart';

class FavoriteTeamWrapper extends StatelessWidget {
  const FavoriteTeamWrapper({
    Key? key,
    required this.team,
    required this.onDelete,
  }) : super(key: key);

  final FavoriteTeam team;
  final Function() onDelete;

  Widget _buildImage(BuildContext context) {
    if (team.image == null || (team.image?.isEmpty ?? false)) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: Image.memory(
        Uint8List.fromList(team.image!),
        height: 48.r,
        width: 48.r,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => FavoriteTeamDetailsPageView(team: team, onDelete: onDelete),
        ),
      ),
      child: SizedBox(
        height: 48.r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildImage(context),
                Text(
                  team.title,
                  style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: whiteColor),
                ),
              ],
            ),
            GestureDetector(
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
                      onPressed: () => onDelete(),
                    ),
                  ],
                ),
              ),
              child: const Icon(Icons.close, color: whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}
