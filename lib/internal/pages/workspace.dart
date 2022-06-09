import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xbet_1/internal/pages/favorite_teams_page/favorite_teams_page.dart';
import 'package:xbet_1/internal/pages/football_teams_page/football_teams_page.dart';
import 'package:xbet_1/internal/pages/settings_page/settings_page.dart';
import 'package:xbet_1/internal/services/app_redirects.dart';
import 'package:xbet_1/internal/services/service_locator.dart';
import 'package:xbet_1/internal/states/subscription_state/subscription_state.dart';
import 'package:xbet_1/internal/utils/infrastructure.dart';
import 'package:xbet_1/presentation/global/icons/bet_icons.dart';

class Workspace extends StatefulWidget {
  const Workspace({Key? key}) : super(key: key);

  static const routeName = '/workspace';

  @override
  State<Workspace> createState() => _WorkspaceState();
}

class _WorkspaceState extends State<Workspace> {
  final PageController _pageController = PageController(initialPage: 1);

  /// Индекс текущей страницы.
  int _currentPage = 1;

  @override
  void initState() {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      if (!service<SubscriptionState>().isSubscribed) {
        goToSubscriptionPage(context);
      }
    });

    super.initState();
  }

  Map<BottomNavigationBarItem, Widget> _itemToPage(BuildContext context) {
    return {
      BottomNavigationBarItem(
        icon: SvgPicture.asset(BetIcons.favorite_team, color: whiteColor.withOpacity(0.4)),
        activeIcon: SvgPicture.asset(BetIcons.favorite_team, color: blueColor),
        label: '',
      ): const FavoriteTeamsPage(),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(BetIcons.football_team, color: whiteColor.withOpacity(0.4)),
        activeIcon: SvgPicture.asset(BetIcons.football_team, color: blueColor),
        label: '',
      ): const FootballTeamsPage(),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(BetIcons.settings, color: whiteColor.withOpacity(0.4)),
        activeIcon: SvgPicture.asset(BetIcons.settings, color: blueColor),
        label: '',
      ): const SettingsPage(),
    };
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      currentIndex: _currentPage,
      backgroundColor: backgroundColor,
      items: _itemToPage(context).keys.toList(),
      onTap: (page) => _pageController.jumpToPage(page),
    );
  }

  Widget _buildPageView(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: _itemToPage(context).values.toList(),
      onPageChanged: (page) => setState(() => _currentPage = page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageView(context),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }
}
