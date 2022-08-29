import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../table_of_contents/bloc/table_of_contents/table_of_contents_bloc.dart';
import 'local_widgets/nav_drawer_menu_item.dart';

class DocsMenuItem extends StatelessWidget {
  const DocsMenuItem({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return NavDrawerMenuItem(
      leadingIconData: Icons.folder_outlined,
      title: 'Документы',
      index: index,
      children: [
        Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: SingleChildScrollView(
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.popAndPushNamed(
                        context,
                        '/',
                      );
                    },
                    child: Container(
                        color: Theme.of(context)
                            .navigationRailTheme
                            .backgroundColor,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.height * 0.05,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                child: Image.asset('assets/images/icon.png')),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(context
                                .read<TableOfContentsBloc>()
                                .regulationAbbreviation),
                          ],
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color: Theme.of(context)
                                  .navigationRailTheme
                                  .backgroundColor,
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Column(
                                children: [
                                  Text('Nyutgjjhg'),
                                  Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Не надо')),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Пригодится')),
                                    ],
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Container(
                        color: Theme.of(context)
                            .navigationRailTheme
                            .backgroundColor,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3),
                                child: Icon(
                                  Icons.add,
                                  size:
                                      MediaQuery.of(context).size.height * 0.03,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.04,
                              ),
                              Text(
                                'Добавить документ',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.02),
                              ),
                            ])),
                  ),
                ]),
              ),
            ),
          ),
        )
      ],
    );
  }
}
