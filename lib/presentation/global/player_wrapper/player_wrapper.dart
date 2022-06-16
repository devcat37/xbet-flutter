import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbet_1/domain/models/player/player.dart';
import 'package:xbet_1/internal/services/helpers.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';

class PlayerWrapper extends StatelessWidget {
  const PlayerWrapper({
    Key? key,
    required this.player,
    this.onPressed,
    this.isPicked = false,
  }) : super(key: key);

  final Player player;
  final Function()? onPressed;

  final bool isPicked;

  Widget _buildImage(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: player.image,
      height: 48.h,
      width: 37.w,
      errorWidget: (_, __, ___) => SizedBox(height: 48.h, width: 37.w),
    );
  }

  Widget _buildInformation(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '#${player.number} ${player.name}',
          style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: isPicked ? blueColor : whiteColor),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            Text(
              player.position,
              style: TextStyle(fontSize: 12.w, fontWeight: FontWeight.w500, color: whiteColor.withOpacity(0.4)),
            ),
            SizedBox(width: 4.w),
            SizedBox(
              height: 9.h,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => CachedNetworkImage(
                  width: 15.w,
                  imageUrl: 'https://flagcdn.com/w20/${countryCodeFromCountry(player.countries.elementAt(index))}.png',
                ),
                separatorBuilder: (_, __) => SizedBox(width: 4.w),
                itemCount: player.countries.length,
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 48.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildImage(context),
                SizedBox(width: 12.w),
                _buildInformation(context),
              ],
            ),
            if (isPicked)
              Container(
                height: 24.r,
                width: 24.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: blueColor, width: 1.0),
                ),
                child: Center(
                  child: Container(
                    height: 10.r,
                    width: 10.r,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: blueColor),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
