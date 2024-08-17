import 'dart:math';

import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/session.dart';
import 'package:openViewF1/view_models/session_view_model.dart';
import 'package:openViewF1/helpers/constants.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeWidget();
}

class _HomeWidget extends State<Home> {
  late SessionViewModel sessionViewModel;

  @override
  void initState() {
    super.initState();
    sessionViewModel = Provider.of<SessionViewModel>(context, listen: false);
    sessionViewModel.fetchSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenViewF1'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          MenuAnchor(
            menuChildren: <Widget>[
              // TODO: Create a swap view button
              MenuItemButton(onPressed: () {}, child: const Text('Grid')),
              MenuItemButton(onPressed: () {}, child: const Text('Filter by')),
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
          return viewModel.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) =>
                      const Divider(height: 0),
                  itemCount: viewModel.sessions.length,
                  itemBuilder: (context, index) {
                    return SessionCard(session: viewModel.sessions[index]);
                  },
                );
        },
      ),
    );
  }
}
