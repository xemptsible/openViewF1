import 'package:flutter/material.dart';
import 'package:openViewF1/helpers/constants.dart';
import 'package:openViewF1/view_models/meeting_view_model.dart';
import 'package:openViewF1/views/components/app_bar.dart';
import 'package:provider/provider.dart';

import 'components/meeting_components.dart';

class MeetingView extends StatefulWidget {
  const MeetingView({super.key});

  @override
  State<StatefulWidget> createState() => _MeetingState();
}

class _MeetingState extends State<MeetingView> {
  late MeetingViewModelImpl meetingViewModel;
  late ViewType view;

  @override
  void initState() {
    super.initState();
    meetingViewModel = Provider.of<MeetingViewModelImpl>(context, listen: false);
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
      body: Consumer<MeetingViewModelImpl>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (viewModel.errorMsg != "" && viewModel.list.isEmpty) {
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
          } else if (viewModel.list.isEmpty) {
            return const Center(
              child: Text("There's nothing here. Please fix your filters"),
            );
          }
          return view == ViewType.list
              ? ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0),
                  itemCount: viewModel.list.length,
                  itemBuilder: (context, index) {
                    return MeetingListItem(data: viewModel.list[index]);
                  },
                )
              : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,
                  ),
                  padding: const EdgeInsets.all(pad8),
                  itemCount: viewModel.list.length,
                  itemBuilder: (context, index) {
                    return MeetingGridItem(data: viewModel.list[index]);
                  },
                );
        },
      ),
    );
  }
}
