import 'package:flutter/widgets.dart';

const String openF1Url = "api.openf1.org";
const String version = "/v1";
const String openF1 = "https://api.openf1.org/v1";
const String imageAssetPath = "assets/flags";

const double pad4 = 4.0;
const double pad8 = 8.0;
const double pad16 = 16.0;
const double pad24 = 24.0;

enum ViewType { grid, list }

changeViewType(ViewType viewType) {
  return viewType = viewType == ViewType.list ? ViewType.grid : ViewType.list;
}
