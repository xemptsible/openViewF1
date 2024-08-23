import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/session.dart';
import 'package:openViewF1/helpers/constants.dart';
import 'package:openViewF1/view_models/session_view_model.dart';
import 'package:openViewF1/views/components/components.dart';
import 'package:provider/provider.dart';

class SessionView extends StatefulWidget {
  const SessionView({super.key, required this.queryParams});

  final dynamic queryParams;

  @override
  State<StatefulWidget> createState() => _SessionState();
}

class _SessionState extends State<SessionView> {
  late SessionViewModel sessionViewModel;

  late ViewType viewType;
  Widget? test;

  @override
  void initState() {
    super.initState();
    sessionViewModel = Provider.of<SessionViewModel>(context, listen: false);
    sessionViewModel.fetchDataWithQuery(widget.queryParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(
        appBarTitle: Consumer<SessionViewModel>(
          builder: (context, viewModel, _) {
            if (!viewModel.isLoading) {
              return Text(viewModel.sessions.isNotEmpty
                  ? '${viewModel.sessions.first.countryName}'
                  : "Error!");
            }
            return const Text('Loading...');
          },
        ),
        viewTypeCallback: (ViewType viewType) {
          viewType = changeViewType(viewType);
          print(viewType);
        },
      ),
      body: Consumer<SessionViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (viewModel.errorMsg != "" && viewModel.sessions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(viewModel.errorMsg),
                  OutlinedButton(
                    onPressed: () {
                      viewModel.fetchDataWithQuery(widget.queryParams);
                      viewModel.errorMsg = "";
                    },
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          } else if (viewModel.sessions.isEmpty) {
            return const Center(
              child: Text("There's nothing here. Please fix your filters"),
            );
          }
          return ListView.builder(
            itemCount: viewModel.sessions.length,
            itemBuilder: (context, index) {
              return SessionListItem(data: viewModel.sessions[index]);
            },
          );
        },
      ),
    );
  }
}
