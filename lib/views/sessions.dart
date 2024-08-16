import 'package:flutter/material.dart';
import 'package:openViewF1/data/models/session.dart';
import 'package:openViewF1/data/view_models/session_view_model.dart';
import 'package:provider/provider.dart';

class SessionsView extends StatefulWidget {
  const SessionsView({super.key});

  @override
  State<StatefulWidget> createState() => _SessionState();
}

class _SessionState extends State<SessionsView> {
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
        title: const Text('Sessions'),
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
