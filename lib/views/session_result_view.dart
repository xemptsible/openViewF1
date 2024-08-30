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
  late final PositionViewModel positionViewModel;
  late final DriverViewModel driverViewModel;

  @override
  void initState() {
    super.initState();
    positionViewModel = Provider.of<PositionViewModel>(context, listen: false);
    positionViewModel.fetchDataWithQuery(widget.queryParams);

    driverViewModel = Provider.of<DriverViewModel>(context, listen: false);
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
    return Consumer2<PositionViewModel, DriverViewModel>(
      builder: (context, pos, dri, child) {
        final driverPos = pos.positions;
        final driverInfo = dri.drivers;

        if (pos.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (pos.errorMsg != "" && pos.positions.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(pos.errorMsg),
                OutlinedButton(
                  onPressed: () {
                    pos.fetchDataWithQuery(widget.queryParams);
                    pos.errorMsg = "";
                  },
                  child: const Text('Retry'),
                )
              ],
            ),
          );
        } else if (pos.positions.isEmpty) {
          return const Center(
            child: Text("There's nothing here. Please fix your filters"),
          );
        }
        return ListView.builder(
          itemCount: pos.positions.length,
          itemBuilder: (context, index) {
            return SessionResultItem(
              position: driverPos[index],
              driver: driverInfo[dri.drivers.indexWhere((element) =>
                  element.driverNumber == driverPos[index].driverNumber)],
            );
          },
        );
      },
    );
  }
}
