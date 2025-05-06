import 'package:flutter/widgets.dart';
import 'package:opper_submodule/design/opper_colors.dart';
import 'package:opper_submodule/data/models/priority_model.dart';

class SliderOverlayData {
  final double? value;
  final Color color;

  SliderOverlayData({
    required this.value,
    required this.color,
  });
}

// ignore: must_be_immutable
class AlignSlider extends StatefulWidget {
  final int valueIndex;
  final ValueChanged<double>? onChanged;
  final List<OpperPriority> priorities;

  const AlignSlider({
    super.key,
    this.onChanged,
    required this.valueIndex,
    required this.priorities,
  });

  @override
  State<AlignSlider> createState() => _AlignSliderState();
}

class _AlignSliderState extends State<AlignSlider> {
  double position = 0.0; // Add this line
  double thumbSize = 24.0;
  double trackHeight = 4.0;
  Color thumbColor = OpperColors.seedColor;
  Color rightTrackColor = OpperColors.purple;
  Color leftTrackColor = OpperColors.seedColor;
  double sliderValue = 0.0;
  double minValue = 0.0;
  double maxValue = 100.0;
  double maxWidth = 100.0; // initializes clamp value
  bool isDragging = false;
  GlobalKey textKey = GlobalKey();
  String sliderLabelText = '';
  bool showLabel = false;
  bool hasMoved = false;

  Color unmovedColor = OpperColors.seedColor;
  List<SliderOverlayData> overlayData = [];

  @override
  void initState() {
    super.initState();
    _assembleOverlayData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {}
    });
  }

  _assembleOverlayData() {
    if (widget.priorities.isEmpty) {
      print("No priorities provided.");
      return;
    }

    for (var i = 0; i < widget.priorities.length; i++) {
      double? value;
      switch (widget.valueIndex) {
        case 0:
          value = widget.priorities[i].impact;
          break;
        case 1:
          value = widget.priorities[i].effort;
          break;
        case 2:
          value = widget.priorities[i].urgency;
          break;
      }

      Color color = AlignColors.getColorByIndex(i);
      overlayData.add(SliderOverlayData(value: value, color: color));
    }
    return overlayData;
  }

  @override
  void dispose() {
    super.dispose();
  }

  positionFromSliderValue(double sliderValue, maxWidth) {
    return (sliderValue - minValue) /
        (maxValue - minValue) *
        (maxWidth - thumbSize / 2);
  }

  sliderValueFromPosition(double position, maxWidth) {
    return minValue +
        (maxValue - minValue) * (position / (maxWidth - thumbSize));
  }

  updateParent(double position, double maxWith) {
    hasMoved = true;
    widget.onChanged?.call(sliderValueFromPosition(position, maxWidth));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: thumbSize * 2,
      child: LayoutBuilder(
        builder: (context, constraints) {
          maxWidth = constraints.maxWidth;
          sliderValue = sliderValueFromPosition(position, maxWidth);

          // right side track
          return Stack(
            children: [
              // Full Track (right side)
              Positioned(
                top: (constraints.maxHeight) / 2, // Center vertically
                child: SizedBox(
                  height: thumbSize,
                  width: constraints.maxWidth, // Use the width of the parent
                  child: CustomPaint(
                    painter:
                        _Track(color: rightTrackColor, trackSize: trackHeight),
                  ),
                ),
              ),

              for (SliderOverlayData data in overlayData)
                if (data.value == null)
                  Container()
                else
                  Positioned(
                      left: positionFromSliderValue(data.value!, maxWidth),
                      top: (constraints.maxHeight) / 2,
                      // Center vertically
                      child: Container(
                          width: thumbSize,
                          height: thumbSize,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: data.color,
                          ))),
            ],
          );
        },
      ),
    );
  }
}

class Label extends StatefulWidget {
  final double position;
  final BoxConstraints constraints;
  final double sliderValue;
  final String labelText;
  final Color labelColor;

  const Label({
    super.key,
    required this.position,
    required this.constraints,
    required this.sliderValue,
    required this.labelText,
    required this.labelColor,
  });

  @override
  State<Label> createState() => _LabelState();
}

class _LabelState extends State<Label> {
  double textWidth = 0.0;
  double maxTextWidth = 0.0; // Add this line

  @override
  Widget build(BuildContext context) {
    final GlobalKey textKey = GlobalKey();
    return Positioned(
      left: widget.sliderValue >= 50
          ? widget.position - maxTextWidth // Modify this line
          : widget.position, // Center horizontally
      top: (widget.constraints.maxHeight) / 2 -
          30, // Adjust vertical position above the thumb
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: OpperColors.unselected,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Builder(
          builder: (context) {
            // Use the GlobalKey to get the RenderBox and measure the Text widget's size
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final renderBox =
                  textKey.currentContext?.findRenderObject() as RenderBox?;
              if (renderBox != null) {
                final size = renderBox.size;
                textWidth = size.width;
                if (textWidth > maxTextWidth) {
                  // Add this block
                  setState(() {
                    maxTextWidth = textWidth;
                  });
                }
              }
            });

            return Text(
              style: TextStyle(color: widget.labelColor),
              widget.labelText,
              key: textKey, // Assign the GlobalKey to the Text widget
            );
          },
        ),
      ),
    );
  }
}

class _Track extends CustomPainter {
  final Color color;
  final double trackSize;

  _Track({required this.color, required this.trackSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = trackSize
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
