import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbet_1/domain/models/player/player.dart';
import 'package:xbet_1/domain/models/team/team.dart';
import 'package:xbet_1/internal/services/app_redirects.dart';
import 'package:xbet_1/internal/services/helpers.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';
import 'package:xbet_1/presentation/global/player_wrapper/player_wrapper.dart';

class ChoosePlayersInTeam extends StatefulWidget {
  const ChoosePlayersInTeam({
    Key? key,
    required this.team,
    required this.players,
    this.chosenPlayers = const [],
  }) : super(key: key);

  final Team team;
  final List<Player> players;

  final List<Player> chosenPlayers;

  @override
  State<ChoosePlayersInTeam> createState() => _ChoosePlayersInTeamState();
}

class _ChoosePlayersInTeamState extends State<ChoosePlayersInTeam> {
  Set<Player> _chosenPlayers = {};

  @override
  void initState() {
    _chosenPlayers = widget.chosenPlayers.toSet();
    super.initState();
  }

  Widget _buildTeamInformation(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        height: 80.r,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: widget.team.image,
              height: 80.r,
              width: 80.r,
              fit: BoxFit.contain,
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.team.name,
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
                          image: NetworkImage(
                              'https://flagcdn.com/w20/${countryCodeFromCountry(widget.team.country)}.png'),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      widget.team.country.substring(0, 3).toUpperCase(),
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

  Widget _buildPlayers(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.players.length,
      itemBuilder: (context, index) {
        return PlayerWrapper(
          player: widget.players.elementAt(index),
          isPicked: _chosenPlayers.any((e) => e.id == widget.players.elementAt(index).id),
          onPressed: () => setState(() {
            if (_chosenPlayers.any((e) => e.id == widget.players.elementAt(index).id)) {
              _chosenPlayers.removeWhere((e) => e.id == widget.players.elementAt(index).id);
            } else {
              _chosenPlayers.add(widget.players.elementAt(index));
            }
          }),
        );
      },
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          _buildTeamInformation(context),
          SizedBox(height: 24.h),
          _buildPlayers(context),
        ],
      ),
    );
  }

  Widget _buildPlayersCount(BuildContext context) {
    return AnimatedContainer(
      duration: defaultAnimationDuration,
      height: 24.r,
      width: 24.r,
      decoration: BoxDecoration(
        color: _chosenPlayers.isEmpty ? Colors.transparent : blueColor,
        shape: BoxShape.circle,
      ),
      child: _chosenPlayers.isEmpty
          ? null
          : Center(
              child: Text(
                _chosenPlayers.length.toString(),
                style: TextStyle(fontSize: 12.w, fontWeight: FontWeight.w500, color: whiteColor),
              ),
            ),
    );
  }

  Widget _buildChoosePlayersButton(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius16,
      onTap: () => Navigator.of(context).pop(_chosenPlayers.toList()),
      child: AnimatedContainer(
        duration: defaultAnimationDuration,
        height: 56.h,
        width: MediaQuery.of(context).size.width - 2 * 16.w,
        decoration: BoxDecoration(
          color: blueColor,
          borderRadius: borderRadius16,
        ),
        child: Center(
          child: Text(
            'Choose your players',
            style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: whiteColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Players choosing'),
        backgroundColor: backgroundColor,
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: _buildPlayersCount(context),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: [
          _buildContent(context),
          Positioned(
            bottom: 16.h + MediaQuery.of(context).padding.bottom,
            child: _buildChoosePlayersButton(context),
          ),
        ],
      ),
    );
  }
}
