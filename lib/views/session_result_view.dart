import 'package:flutter/material.dart';
import 'package:openViewF1/view_models/driver_view_model.dart';
import 'package:openViewF1/view_models/position_view_model.dart';
import 'package:openViewF1/views/components/app_bar.dart';
import 'package:provider/provider.dart';

import 'components/position_components.dart';

class SessionResultView extends StatefulWidget {
  final dynamic queryParams;

  const SessionResultView({super.key, this.queryParams});

  @override
  State<SessionResultView> createState() => _SessionResultViewState();
}

class _SessionResultViewState extends State<SessionResultView> {
  late final PositionViewModelImpl positionViewModel;
  late final DriverViewModelImpl driverViewModel;

  @override
  void initState() {
    super.initState();
    positionViewModel = Provider.of<PositionViewModelImpl>(context, listen: false);
    positionViewModel.fetchDataWithQuery(widget.queryParams);

    driverViewModel = Provider.of<DriverViewModelImpl>(context, listen: false);
    driverViewModel.fetchDataWithQuery(widget.queryParams);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarDesign(
        appBarTitle: Text('Result'),
      ),
      body: Column(
        children: [
          const ResultHeader(),
          Expanded(child: _uiListOfMeetings()),
        ],
      ),
    );
  }

  Widget _uiListOfMeetings() {
    return Consumer2<PositionViewModelImpl, DriverViewModelImpl>(
      builder: (context, position, driver, child) {
        final driverPos = position.list;
        final driverInfo = driver.list;

        if (position.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (position.errorMsg != "" && position.list.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(position.errorMsg),
                OutlinedButton(
                  onPressed: () {
                    position.fetchDataWithQuery(widget.queryParams);
                    position.errorMsg = "";
                  },
                  child: const Text('Retry'),
                )
              ],
            ),
          );
        } else if (position.list.isEmpty) {
          return const Center(
            child: Text("There's nothing here. Please fix your filters"),
          );
        }
        return ListView.builder(
          itemCount: position.list.length,
          itemBuilder: (context, index) {
            return SessionResultItem(
              position: driverPos[index],
              driver: driverInfo[driver.list.indexWhere((element) =>
                  element.driverNumber == driverPos[index].driverNumber)],
            );
          },
        );
      },
    );
  }
}
