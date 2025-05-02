import 'package:flutter/material.dart';
import 'package:opper_submodule/data/models/priority_model.dart';
import 'package:opper_submodule/design/opper_colors.dart';
import 'package:opper_submodule/sliders/align_slider.dart';

class ImpactResultsSlider extends StatefulWidget {
  final List<OpperPriority> priorities;
  const ImpactResultsSlider({super.key, required this.priorities});

  @override
  State<ImpactResultsSlider> createState() => _ImpactResultsSliderState();
}

class _ImpactResultsSliderState extends State<ImpactResultsSlider> {
  double height = 92;
  late double impact;

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
                  child: AlignSlider(
                    valueIndex: 0,
                    priorities: widget.priorities,
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
