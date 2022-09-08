import 'package:flutter/material.dart';

class InitAppBAr extends StatelessWidget {
  const InitAppBAr({
    Key? key,
    required this.title,
    required this.name,
  }) : super(key: key);

  final String title, name;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            return MediaQuery.of(context).orientation == Orientation.portrait
                ? IconButton(
                    onPressed: () async {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      size: Theme.of(context).appBarTheme.iconTheme!.size,
                      color: Theme.of(context).appBarTheme.iconTheme!.color,
                    ),
                  )
                : Container();
          },
        ),
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(name)));
          },
          child:
              Text(title, style: Theme.of(context).appBarTheme.titleTextStyle),
        ),
        IconButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/searchScreen',
            );

          },
          icon: Icon(
            Icons.search,
            size: Theme.of(context).appBarTheme.iconTheme!.size,
            color: Theme.of(context).appBarTheme.iconTheme!.color,
          ),
        ),
      ],
    );
  }
}
