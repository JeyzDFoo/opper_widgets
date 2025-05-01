import 'package:flutter/material.dart';
import 'package:opper_submodule/data/models/priority_model.dart';
import 'package:opper_submodule/opper_slider.dart';

class ImpactSlider extends StatefulWidget {
  final OpperPriority? priority;
  const ImpactSlider({super.key, this.priority});

  @override
  State<ImpactSlider> createState() => _ImpactSliderState();
}

class _ImpactSliderState extends State<ImpactSlider> {
  @override
  Widget build(BuildContext context) {
    return OpperSlider(
        sliderValue: 50,
        minValue: 0,
        maxValue: 100,
        onChanged: (value) {
          setState(() {
            widget.priority?.impact = value;
          });
        });
  }
}
