// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// import '../../../../bloc/bottom_bar/bottom_bar_cubit.dart';
// import 'bottom_bar_black_icon.dart';

// class BottomBarBlackTop extends StatelessWidget {
//   const BottomBarBlackTop({
//     Key? key,
//     required this.height,
//     required this.fontHeight,
//   }) : super(key: key);

//   final double height, fontHeight;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => context.read<BottomBarCubit>().collapse(),
      
//       child: Container(
//         decoration: BoxDecoration(border: Border.all(color: Colors.transparent)),
//         height: height * 0.1,
//         width: MediaQuery.of(context).size.width,
//         child: Column(children: [
//           SizedBox(
//             height: height * 0.01,
//           ),
//           BottomBarBlackIcon(
//             height: fontHeight,
//             icon: Icons.keyboard_arrow_down,
//           ),
//         ]),
//       ),
//     );
//   }
// }
