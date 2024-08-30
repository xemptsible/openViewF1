import 'package:flutter/material.dart';
import 'package:openViewF1/helpers/constants.dart';
import 'package:openViewF1/view_models/meeting_view_model.dart';
import 'package:openViewF1/views/components/app_bar.dart';
import 'package:provider/provider.dart';

import 'components/meeting_components.dart';

class MeetingsView extends StatefulWidget {
  const MeetingsView({super.key});

  @override
  State<StatefulWidget> createState() => MeetingState();
}

class MeetingState extends State<MeetingsView> {
  late MeetingViewModel meetingViewModel;
  late ViewType view;

  @override
  void initState() {
    super.initState();
    meetingViewModel = Provider.of<MeetingViewModel>(context, listen: false);
    meetingViewModel.fetchData();

    view = ViewType.list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(
        viewTypeCallback: (p0) => setState(() {
          view = changeViewType(view);
        }),
      ),
      body: view == ViewType.list ? _uiListOfMeetings() : _uiGridOfMeetings(),
    );
  }

  Widget _uiListOfMeetings() {
    return Consumer<MeetingViewModel>(
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
                    viewModel.fetchData();
                    viewModel.errorMsg = "";
                  },
                  child: const Text('Retry'),
                )
              ],
            ),
          );
        } else if (viewModel.meetings.isEmpty) {
          return const Center(
            child: Text("There's nothing here. Please fix your filters"),
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
    );
  }

  Widget _uiGridOfMeetings() {
    return Consumer<MeetingViewModel>(
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
                    viewModel.fetchData();
                    viewModel.errorMsg = "";
                  },
                  child: const Text('Retry'),
                )
              ],
            ),
          );
        } else if (viewModel.meetings.isEmpty) {
          return const Center(
            child: Text("There's nothing here. Please fix your filters"),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.85,
          ),
          padding: const EdgeInsets.all(pad8),
          itemCount: viewModel.meetings.length,
          itemBuilder: (context, index) {
            return MeetingGridItem(data: viewModel.meetings[index]);
          },
        );
      },
    );
  }
}
