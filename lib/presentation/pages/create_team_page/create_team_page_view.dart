// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbet_1/internal/services/app_redirects.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/states/create_team_state/create_team_state.dart';
import 'package:xbet_1/internal/states/subscription_state/subscription_state.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';
import 'package:xbet_1/presentation/global/player_wrapper/player_wrapper.dart';
import 'package:xbet_1/presentation/pages/choose_players_page/choose_players_page_view.dart';

class CreateTeamPageView extends StatelessWidget {
  const CreateTeamPageView({Key? key}) : super(key: key);

  CreateTeamState get state => service<CreateTeamState>();

  Future<bool> popPage(BuildContext context) async {
    return await showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text('Cancel creating'),
            content: Text('Are you sure you want to close the creation of the team? Settings will not be saved'),
            actions: [
              CupertinoDialogAction(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              CupertinoDialogAction(
                child: Text("Yes"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          ),
        ) ??
        false;
  }

  Widget _buildTeamNameInput(BuildContext context) {
    return TextField(
      style: TextStyle(color: whiteColor),
      onChanged: (name) => state.setTeamName(name),
      decoration: InputDecoration(
        hintText: 'Enter your team name',
        hintStyle: TextStyle(color: whiteColor.withOpacity(0.4)),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: whiteColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: whiteColor),
        ),
      ),
    );
  }

  Widget _buildChoosePhotoButton(BuildContext context) {
    return InkWell(
      onTap: () => state.choosePhoto(),
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
            'Choose a photo from gallery',
            style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: whiteColor),
          ),
        ),
      ),
    );
  }

  Widget _buildChoosePlayersButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChoosePlayersPageView(
              chosenPlayers: state.chosenPlayers,
            ),
          ),
        );
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
            'Choose your players',
            style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.w500, color: whiteColor),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoto(BuildContext context) {
    return GestureDetector(
      onTap: () => state.choosePhoto(),
      child: Stack(
        children: [
          Image.memory(
            state.file,
            height: 120.h,
            width: 120.h,
            fit: BoxFit.cover,
          ),
          Positioned(
            right: 6.r,
            top: 6.r,
            child: GestureDetector(
              onTap: () => state.deletePhoto(),
              child: Icon(
                Icons.close,
                color: whiteColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChosenPlayers(BuildContext context) {
    if (state.players.isEmpty) return const SizedBox.shrink();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.players.length,
      itemBuilder: (context, index) => PlayerWrapper(
        player: state.players.elementAt(index),
      ),
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Observer(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create your dream team',
              style: TextStyle(fontSize: 20.w, color: whiteColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24.h),
            _buildTeamNameInput(context),
            SizedBox(height: 24.h),
            if (state.file.isEmpty && service<SubscriptionState>().isSubscribed) _buildChoosePhotoButton(context),
            if (state.file.isNotEmpty) _buildPhoto(context),
            if (service<SubscriptionState>().isSubscribed) SizedBox(height: 24.h),
            _buildChoosePlayersButton(context),
            SizedBox(height: 24.h),
            _buildChosenPlayers(context),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 0,
            title: Text('Team creating'),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: Observer(
                  builder: (context) => state.teamName.isNotEmpty && state.players.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            state.createTeam();

                            pop(context);
                          },
                          child: Icon(Icons.done),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
          body: _buildContent(context),
        ),
        onWillPop: () async => popPage(context));
  }
}
