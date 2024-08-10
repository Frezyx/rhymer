// import 'package:flutter/material.dart';
// import 'package:rhymer/ui/ui.dart';

// class SearchRhymesBottomSheet extends StatelessWidget {
//   const SearchRhymesBottomSheet({
//     super.key,
//     required this.controller,
//   });

//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return BaseBottomSheet(
//       child: Column(
//         children: [
//           const Divider(height: 1),
//           Expanded(
//             child: ListView.separated(
//               itemBuilder: (context, index) => ListTile(
//                 title: const Text('Слово из автокомплита'),
//                 onTap: () {},
//               ),
//               separatorBuilder: (context, _) => const Divider(height: 1),
//               itemCount: 15,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _onTapSearch(BuildContext context) {
//     Navigator.of(context).pop(controller.text);
//   }
// }
