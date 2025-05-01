import 'package:flutter/material.dart';
import 'package:opper_submodule/data/models/priority_model.dart';
import 'package:opper_submodule/design/opper_colors.dart';
import 'package:opper_submodule/opper_slider.dart';

class ImpactSlider extends StatefulWidget {
  final OpperPriority priority;
  final Function(double value)? onChanged;
  const ImpactSlider({super.key, required this.priority, this.onChanged});

  @override
  State<ImpactSlider> createState() => _ImpactSliderState();
}

class _ImpactSliderState extends State<ImpactSlider> {
  double height = 92;
  late double impact;

  @override
  void initState() {
    super.initState();
    impact = widget.priority.impact ?? 50; // Initialize impact here
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: OpperColors.secondaryBackground,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center, // Align children properly
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Impact",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("No Impact"),
                          Text("Life Changing"),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 22),
                  child: OpperSlider(
                    sliderValue: impact,
                    minValue: 0,
                    maxValue: 100,
                    onChanged: (value) {
                      setState(() {
                        impact = value;
                        widget.priority.impact = value;
                        widget.onChanged?.call(value);
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
