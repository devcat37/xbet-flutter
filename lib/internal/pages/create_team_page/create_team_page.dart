import 'package:flutter/material.dart';
import 'package:xbet_1/presentation/pages/create_team_page/create_team_page_view.dart';

class CreateTeamPage extends StatelessWidget {
  const CreateTeamPage({Key? key}) : super(key: key);

  static const routeName = '/create-team-page';

  @override
  Widget build(BuildContext context) {
    return const CreateTeamPageView();
  }
}
