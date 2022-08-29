import 'package:flutter/material.dart';

import 'bottom_bar_black_divider.dart';
import 'buttons/underlined.dart';
import 'buttons/close.dart';
import 'buttons/clean.dart';
import 'buttons/mark.dart';

class BottomBarBlack extends StatelessWidget {
  const BottomBarBlack({
    Key? key,
    required this.height,
    required this.iconSize,
  }) : super(key: key);
  final double height, iconSize;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            color: Colors.black.withOpacity(0.8)),
        width: MediaQuery.of(context).size.width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // BottomBarBlackTop(
            //   height: height,
            //   fontHeight: iconSize,
            // ),
            // context.read<BottomBarCubit>().state
            //     ? BottomBarBlackTop(
            //         height: height,
            //         fontHeight: iconSize,
            //       )
            //     : GestureDetector(
            //         onTap: () => context.read<BottomBarCubit>().expand(),
            //         child: Container(
            //           decoration: BoxDecoration(
            //               border: Border.all(color: Colors.transparent)),
            //           height: height * 0.1,
            //           width: MediaQuery.of(context).size.width,
            //           child: Icon(
            //             Icons.arrow_drop_up_sharp,
            //             color: Theme.of(context)
            //                 .appBarTheme
            //                 .toolbarTextStyle!
            //                 .color,
            //           ),
            //         ),
            //       ),
            Container(
              height: height * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildBottomBarBlack(context, iconSize),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildBottomBarBlack(BuildContext context, double fontHeight) {
    return [
      underlined(fontHeight: fontHeight),
      BottomBarBlackDivider(height: fontHeight),
      mark(fontHeight: fontHeight),
      BottomBarBlackDivider(height: fontHeight),
      clean(fontHeight: fontHeight),
      BottomBarBlackDivider(height: fontHeight),
      close(fontHeight: fontHeight),
    ].toList();
  }
}
