import 'package:flutter/material.dart';
import 'package:openViewF1/view_models/session_view_model.dart';
import 'package:openViewF1/views/components/app_bar.dart';
import 'package:openViewF1/views/components/session_components.dart';
import 'package:provider/provider.dart';

class SessionView extends StatefulWidget {
  const SessionView({super.key, required this.queryParams});

  final dynamic queryParams;

  @override
  State<StatefulWidget> createState() => _listtate();
}

class _listtate extends State<SessionView> {
  late SessionViewModelImpl sessionViewModel;

  @override
  void initState() {
    super.initState();
    sessionViewModel = Provider.of<SessionViewModelImpl>(context, listen: false);
    sessionViewModel.fetchDataWithQuery(widget.queryParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDesign(
        appBarTitle: Consumer<SessionViewModelImpl>(
          builder: (context, session, child) {
            if (!session.isLoading) {
              return Text(session.list.isNotEmpty
                  ? '${session.list.first.countryName}'
                  : "Error!");
            }
            return const Text('Loading...');
          },
        ),
      ),
      body: Consumer<SessionViewModelImpl>(
        builder: (context, session, child) {
          if (session.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (session.errorMsg != "" && session.list.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(session.errorMsg),
                  OutlinedButton(
                    onPressed: () {
                      session.fetchDataWithQuery(widget.queryParams);
                      session.errorMsg = "";
                    },
                    child: const Text('Retry'),
                  )
                ],
              ),
            );
          } else if (session.list.isEmpty) {
            return const Center(
              child: Text("There's nothing here. Please fix your filters"),
            );
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: session.list.length,
            itemBuilder: (context, index) {
              return SessionListItem(
                data: session.list[index],
              );
            },
          );
        },
      ),
    );
  }
}
