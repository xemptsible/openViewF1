import 'dart:math';

import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/meeting.dart';
import 'package:openViewF1/data/models/session.dart';
import 'package:openViewF1/view_models/meeting_view_model.dart';
import 'package:openViewF1/view_models/session_view_model.dart';
import 'package:openViewF1/helpers/constants.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeWidget();
}

class _HomeWidget extends State<Home> {
  late MeetingViewModel meetingViewModel;

  @override
  void initState() {
    super.initState();
    meetingViewModel = Provider.of<MeetingViewModel>(context, listen: false);
    meetingViewModel.fetchMeetings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('OpenViewF1'),
        actions: [
          // IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          MenuAnchor(
            menuChildren: <Widget>[
              // TODO: Create a swap view button
              MenuItemButton(
                  onPressed: () {},
                  leadingIcon: const Icon(Icons.grid_view_sharp),
                  child: const Text('Grid View')),
              MenuItemButton(
                  onPressed: () {},
                  leadingIcon: const Icon(Icons.filter_alt),
                  child: const Text('Filter')),
              MenuItemButton(
                  onPressed: () {},
                  leadingIcon: const Icon(Icons.settings),
                  child: const Text('Settings')),
            ],
            builder: (context, controller, child) {
              return IconButton(
                  onPressed: () {
                    controller.isOpen ? controller.close() : controller.open();
                  },
                  icon: const Icon(Icons.more_vert));
            },
          )
        ],
      ),
      body: Consumer<MeetingViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (viewModel.errorMsg != "" && viewModel.meetings.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(viewModel.errorMsg),
                  OutlinedButton(
                    onPressed: () {
                      viewModel.fetchMeetings();
                      viewModel.errorMsg = "";
                    },
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          }
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(height: 0),
            itemCount: viewModel.meetings.length,
            itemBuilder: (context, index) {
              return MeetingListItem(data: viewModel.meetings[index]);
            },
          );
        },
      ),
    );
  }
}
