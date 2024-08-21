import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/session.dart';
import 'package:openViewF1/view_models/session_view_model.dart';
import 'package:provider/provider.dart';

class SessionDetail extends StatefulWidget {
  const SessionDetail({super.key, required this.queryParams});

  final dynamic queryParams;

  @override
  State<StatefulWidget> createState() => _SessionState();
}

class _SessionState extends State<SessionDetail> {
  late SessionViewModel sessionViewModel;

  @override
  void initState() {
    super.initState();
    sessionViewModel = Provider.of<SessionViewModel>(context, listen: false);
    sessionViewModel.fetchSessionsByQuery(widget.queryParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Consumer<SessionViewModel>(builder: (context, viewModel, _) {
          if (!viewModel.isLoading) {
            return Text(viewModel.sessions.isNotEmpty
                ? '${viewModel.sessions.first.countryName}'
                : "Error!");
          }
          return const Text('Loading...');
        }),
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
                      viewModel.fetchSessionsByQuery(widget.queryParams);
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
