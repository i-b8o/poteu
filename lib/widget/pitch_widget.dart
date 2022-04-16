import 'package:flutter/material.dart';
import 'package:poteu/bloc/bloc.dart';
import 'package:provider/provider.dart';

class PitchWidget extends StatelessWidget {
  const PitchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Bloc>(builder: (context, _bloc, _) {
      return StreamBuilder<Object>(
          stream: _bloc.pitchStream,
          builder: (context, snapshot) {
            return Row(
              children: <Widget>[
                new IconButton(
                  icon: new Icon(
                    Icons.arrow_circle_down,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    _bloc.decreasePitch();
                    _bloc.speak(
                        "Правила по охране труда при эксплуатации электроустановок (далее - Правила) устанавливают государственные нормативные требования охраны труда");
                  },
                ),
                new Text(_bloc.pitch.round().toString() + "%"),
                new IconButton(
                    icon: new Icon(Icons.arrow_circle_up, color: Colors.teal),
                    onPressed: () {
                      _bloc.increasePitch();
                      _bloc.speak(
                          "Правила по охране труда при эксплуатации электроустановок (далее - Правила) устанавливают государственные нормативные требования охраны труда");
                    }),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Тон",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            );
          });
    });
  }
}
