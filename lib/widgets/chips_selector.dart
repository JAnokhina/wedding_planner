import 'package:flutter/material.dart';

import '../main.dart';
import '../themes.dart';

class ChipSelector extends StatefulWidget {
  ChipSelector(
      {Key? key, required this.choices, this.onSelected, this.chosenIndex})
      : super(key: key);
  final List<String> choices;
  int? chosenIndex;
  final Function(int index, bool isSelected)? onSelected;

  @override
  State<ChipSelector> createState() => _ChipSelectorState();
}

class _ChipSelectorState extends State<ChipSelector> {
  int _choiceIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.chosenIndex != null) {
      _choiceIndex = widget.chosenIndex!;
    }
    return SizedBox(
      width: displayWidth(context),
      height: 60,
      child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int index = 0; index < widget.choices.length; index++) ...[
              ChoiceChip(
                label: Text(widget.choices[index]),
                selected: _choiceIndex == index,
                selectedColor: AppColours.primary,
                onSelected: (bool selected) {
                  widget.chosenIndex = null;
                  setState(() {
                    _choiceIndex = selected ? index : 0;
                    print(selected);
                    print(index);
                    widget.onSelected!(index, selected);
                  });
                },
                backgroundColor: AppColours.secondary,
                labelStyle: TextStyle(color: Colors.white),
              )
            ]
          ]),
    );
  }
}