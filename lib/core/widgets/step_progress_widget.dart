import 'package:flutter/material.dart';

class StepProgressWidget extends StatefulWidget {
  final List<String> stepData;
  final int currentStep;

  const StepProgressWidget(
      {Key? key, required this.stepData, required this.currentStep})
      : super(key: key);

  @override
  State<StepProgressWidget> createState() => _StepProgressWidgetState();
}

class _StepProgressWidgetState extends State<StepProgressWidget> {
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    currentStep = widget.currentStep;

    return FittedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Row(
            children: widget.stepData
                .asMap()
                .map(
                  (key, value) => MapEntry(
                    key,
                    _buildStepItem(key + 1, value),
                  ),
                )
                .values
                .toList()),
      ),
    );
  }

  Widget _buildStepItem(int index, String text) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 2,
              width: MediaQuery.of(context).size.width * .08,
              color: index > 1
                  ? currentStep == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey
                  : Colors.transparent,
            ),
            Container(
              width: 32,
              height: 32,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: currentStep == index
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Text(
                index.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: currentStep == index ? Colors.white : Colors.black,
                ),
              ),
            ),
            Container(
              height: 2,
              width: MediaQuery.of(context).size.width * .08,
              color: index != widget.stepData.length
                  ? currentStep == index
                      ? Theme.of(context).primaryColor
                      : Colors.grey
                  : Colors.transparent,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 12,
                color: currentStep == index
                    ? Theme.of(context).primaryColor
                    : Colors.grey),
          ),
        )
      ],
    );
  }
}
