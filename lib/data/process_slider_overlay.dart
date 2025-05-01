import 'dart:core';

import 'package:opper/data/models/user.dart';
import 'package:opper/design/colors.dart';
import 'package:opper/data/models/priority_model.dart';
import 'package:opper/jeyz_widgets/jeyz_slider.dart';

//overlayType should be "impact", "effort", or "urgency"
List<SliderOverlayData> getOverlaydata(
    List<Priority> priorities, OpperUser localUser, String overlayType) {
  List<SliderOverlayData> overlayValues = [];
  //remove localUser from list by localUser.uid
  List<Priority> overlayPriorities =
      priorities.where((element) => element.user.uid != localUser.uid).toList();

  for (int i = 0; i < overlayPriorities.length; i++) {
    if (overlayType == "impact" && overlayPriorities[i].impact != null) {
      overlayValues.add(SliderOverlayData(
          value: overlayPriorities[i].impact!,
          color: PalletColors().getPalletColorByIndex(i).primary));
    } else if (overlayType == "effort" && overlayPriorities[i].effort != null) {
      overlayValues.add(SliderOverlayData(
          value: overlayPriorities[i].effort!,
          color: PalletColors().getPalletColorByIndex(i).primary));
    } else if (overlayType == "urgency" &&
        overlayPriorities[i].urgency != null) {
      overlayValues.add(SliderOverlayData(
          value: overlayPriorities[i].urgency!,
          color: PalletColors().getPalletColorByIndex(i).primary));
    }
  }

  return overlayValues;
}
