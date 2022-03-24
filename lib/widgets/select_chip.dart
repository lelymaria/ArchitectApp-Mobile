import 'package:architect_app/utils/dimension.dart';
import 'package:flutter/material.dart';

class SelectChip extends StatefulWidget {
  final List<String> listChoice;
  String selectedChoice;
  final Function(String) onSelectionChanged;

  SelectChip(this.listChoice, {this.onSelectionChanged, this.selectedChoice});

  @override
  _SelectChipState createState() => _SelectChipState();
}

class _SelectChipState extends State<SelectChip> {
  String _selectedChoice;

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.listChoice.forEach((item) {
      choices.add(Container(
        padding: EdgeInsets.all(2.0),
        child: ChoiceChip(
          backgroundColor: Colors.transparent,
          shape: StadiumBorder(side: BorderSide(color: Colors.black12)),
          label: Text(
            " $item ",
            style: TextStyle(
                color: Colors.black,
                fontSize: Dimension.safeBlockVertical * 1.8),
          ),
          selected: widget.selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              widget.selectedChoice = item;
              print(
                  "choice ${widget.selectedChoice} and $_selectedChoice and $item");
              widget.onSelectionChanged(widget.selectedChoice);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    Dimension().init(context);
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
