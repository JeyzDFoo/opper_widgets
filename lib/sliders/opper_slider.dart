import 'package:flutter/widgets.dart';
import 'package:opper_submodule/design/opper_colors.dart';

class SliderOverlayData {
  final double value;
  final Color color;

  SliderOverlayData({
    required this.value,
    required this.color,
  });
}

// ignore: must_be_immutable
class OpperSlider extends StatefulWidget {
  final ValueChanged<double>? onChanged; // Add this line
  final double sliderValue; // Add this line
  final double minValue; // Add this line
  final double maxValue; // Add this line
  final List<SliderOverlayData>? overlayValues;
  final bool? urgencySlider;
  final bool lockSlider;
  final bool? hasMoved;
  bool? showOverlay;

  OpperSlider({
    super.key,
    this.onChanged,
    required this.sliderValue,
    required this.minValue,
    required this.maxValue,
    this.overlayValues,
    this.hasMoved,
    this.urgencySlider = false,
    this.lockSlider = false,
    this.showOverlay = true,
  }); // Modify this line

  @override
  State<OpperSlider> createState() => _OpperSliderState();
}

class _OpperSliderState extends State<OpperSlider> {
  double position = 0.0; // Add this line
  double thumbSize = 30.0;
  double trackHeight = 5.0;
  Color thumbColor = OpperColors.seedColor;
  Color trackColor = OpperColors.seedColor.withAlpha(120);
  double sliderValue = 0.0;
  double minValue = 0.0;
  double maxValue = 100.0;
  double maxWidth = 100.0; // initializes clamp value
  bool isDragging = false;
  GlobalKey textKey = GlobalKey();
  String sliderLabelText = '';
  bool showLabel = false;
  bool hasMoved = false;

  Color unmovedColor =
      OpperColors.unselected.withRed(100).withBlue(100).withGreen(100);

  @override
  void initState() {
    super.initState();

    if (widget.urgencySlider == true && widget.lockSlider == true) {
      widget.showOverlay = false;
    }

    hasMoved = widget.hasMoved ?? false;
    minValue = widget.minValue;
    maxValue = widget.maxValue;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          position = (widget.sliderValue - minValue) /
              (maxValue - minValue) *
              (maxWidth - thumbSize);
        });
      }
    });
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
    if (!hasMoved) {
      thumbColor = unmovedColor;
    } else {
      thumbColor = OpperColors.seedColor;
    }

    return Container(
      height: thumbSize * 2,
      child: LayoutBuilder(
        builder: (context, constraints) {
          maxWidth = constraints.maxWidth;
          sliderValue = sliderValueFromPosition(position, maxWidth);

          if (widget.urgencySlider == true) {
            //   sliderLabelText = calcTimeOutFromUrgency(sliderValue);
          } else {
            sliderLabelText = (sliderValue * 0.1).toStringAsFixed(1);
          }

          return Stack(
            children: [
              //track
              Positioned(
                top: (constraints.maxHeight) / 2, // Center vertically
                child: GestureDetector(
                  onTapDown: (details) {
                    if (!widget.lockSlider) {
                      setState(() {
                        position = details.localPosition.dx;
                        // Ensure the position stays within the track bounds
                        position = position.clamp(
                            0.0, constraints.maxWidth - thumbSize);
                        isDragging = true;
                        showLabel = true; // Add this line
                        updateParent(position, maxWidth);
                      });
                    }
                  },
                  onHorizontalDragStart: (details) {
                    if (!widget.lockSlider) {
                      setState(() {
                        isDragging = true;
                        showLabel = true; // Add this line
                        updateParent(position, maxWidth);
                      });
                    }
                  },
                  onHorizontalDragUpdate: (details) {
                    if (!widget.lockSlider) {
                      setState(() {
                        position += details.delta.dx;
                        // Ensure the position stays within the track bounds
                        position = position.clamp(
                            0.0, constraints.maxWidth - thumbSize);
                        updateParent(position, maxWidth);
                      });
                    }
                  },
                  onHorizontalDragEnd: (details) {
                    if (!widget.lockSlider) {
                      setState(() {
                        position = position.clamp(
                            0.0, constraints.maxWidth - thumbSize);
                        isDragging = false;
                        updateParent(position, maxWidth);
                      });
                    }
                  },
                  child: SizedBox(
                    height: thumbSize,
                    width: constraints.maxWidth, // Use the width of the parent
                    child: CustomPaint(
                      painter:
                          _Track(color: trackColor, trackSize: trackHeight),
                    ),
                  ),
                ),
              ),
              if (widget.overlayValues != null && widget.showOverlay == true)
                for (var otherValue in widget.overlayValues!)
                  Positioned(
                      left: positionFromSliderValue(otherValue.value, maxWidth),
                      top: (constraints.maxHeight) / 2 - thumbSize * 0.12 - 5,
                      // Center vertically
                      child: Container(
                        width: thumbSize * 0.12,
                        height: thumbSize * 0.12,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AlignColors.getColorByIndex(
                                widget.overlayValues!.indexOf(otherValue)),
                            boxShadow: [
                              BoxShadow(
                                color: otherValue.color.withAlpha(100),
                                blurRadius: 6.0,
                                spreadRadius: 0.0,
                              ),
                            ]),
                      )),
              Positioned(
                left: position,
                top: (constraints.maxHeight) / 2, // Center vertically
                child: GestureDetector(
                  onHorizontalDragStart: (details) {
                    if (!widget.lockSlider) {
                      setState(() {
                        isDragging = true; // Add this line
                        showLabel = true; // Add this line
                        updateParent(position, maxWidth);
                      });
                    }
                  },
                  onHorizontalDragUpdate: (details) {
                    if (!widget.lockSlider) {
                      setState(() {
                        position += details.delta.dx;
                        // Ensure the position stays within the track bounds
                        position = position.clamp(
                            0.0, constraints.maxWidth - thumbSize);
                      });
                    }
                  },
                  onHorizontalDragEnd: (details) {
                    if (!widget.lockSlider) {
                      setState(() {
                        position = position.clamp(
                            0.0, constraints.maxWidth - thumbSize);
                        isDragging = false; // Add this line
                        updateParent(position, maxWidth);
                      });
                    }
                  },
                  child: Container(
                    width: thumbSize, // Set the desired width
                    height: thumbSize, // Set the desired height
                    decoration: BoxDecoration(
                      boxShadow: [
                        // BoxShadow(
                        //   color: seedColor,
                        //   blurRadius: 6.0,
                        //   spreadRadius: 0.0,
                        // ),
                      ],
                      color: !widget.lockSlider
                          ? thumbColor
                          : OpperColors.unselected,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              if (showLabel)
                Label(
                    labelColor: thumbColor,
                    labelText: sliderLabelText,
                    constraints: constraints,
                    position: position,
                    sliderValue: sliderValue),
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
