import 'package:flutter/material.dart';
import 'package:opper_submodule/data/models/priority_model.dart';
import 'package:opper_submodule/design/opper_colors.dart';
import 'package:opper_submodule/sliders/align_slider.dart';

class EffortResultsSlider extends StatefulWidget {
  final List<OpperPriority>? priorities;
  const EffortResultsSlider({super.key, required this.priorities});

  @override
  State<EffortResultsSlider> createState() => _EffortResultsSliderState();
}

class _EffortResultsSliderState extends State<EffortResultsSlider> {
  double height = 92;

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
                            "Effort",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 22),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("No Effort"),
                          Text("Impossible"),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 22),
                  child: AlignSlider(
                    valueIndex: 1,
                    priorities: widget.priorities!,
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
