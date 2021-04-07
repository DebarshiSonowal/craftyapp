import 'package:flutter/material.dart';

/// Requires a list of string ['Male','Female','Other'] only once.

class GenderField extends StatelessWidget {

  final List<String> genderList;
  final ValueSetter<String> callback;
  final String def;

  GenderField({@required this.genderList, this.def,@required this.callback});

  @override
  Widget build(BuildContext context) {
    String select=def!=null?def:null;
    Map<int, String> mappedGender = genderList.asMap();

    return StatefulBuilder(
      builder: (_, StateSetter setState) =>
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Gender : ',
                style: TextStyle(fontWeight: FontWeight.w400,
                color: Colors.black),
              ),
              ...mappedGender.entries.map(
                    (MapEntry<int, String> mapEntry) =>
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            activeColor: Colors.black,
                            groupValue: select,
                            value: genderList[mapEntry.key],
                            onChanged: (value) {
                              callback(value);
                              setState(() => {
                                select = value
                              });
                              },
                          ),
                          Text(mapEntry.value,style: TextStyle(
                            color: Colors.black
                          ),)
                        ]),
              ),
            ],
          ),
    );
  }
}