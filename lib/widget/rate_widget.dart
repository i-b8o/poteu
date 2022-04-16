import 'package:flutter/material.dart';
import 'package:poteu/bloc/bloc.dart';
import 'package:provider/provider.dart';

class RateWidget extends StatelessWidget {
  const RateWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Bloc>(builder: (context, _bloc, _) {
      return StreamBuilder<double>(
          stream: _bloc.rateStream,
          builder: (context, snapshot) {
            return Row(
              children: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.arrow_circle_down,
                      color: Colors.redAccent),
                  onPressed: () {
                    _bloc.decreaseRate();
                    _bloc.speak(
                        "Правила по охране труда при эксплуатации электроустановок (далее - Правила) устанавливают государственные нормативные требования охраны труда");
                  },
                ),
                new Text(_bloc.rate.round().toString() + "%"),
                new IconButton(
                    icon: new Icon(Icons.arrow_circle_up, color: Colors.teal),
                    onPressed: () {
                      _bloc.increaseRate();
                      _bloc.speak(
                          "Правила по охране труда при эксплуатации электроустановок (далее - Правила) устанавливают государственные нормативные требования охраны труда");
                    }),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Скорость",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            );
          });
    });
  }
}
