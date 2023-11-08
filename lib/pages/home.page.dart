import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DateTime _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Row(
          children: [
            // left side pane
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: [
            //         // pomodoros counter
            //         Row(
            //           children: [
            //             Spacer(),
            //             Row(
            //               children: [
            //                 Container(
            //                   decoration: BoxDecoration(
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(16)),
            //                     color: Colors.blue[100],
            //                   ),
            //                   width: 16,
            //                   height: 16,
            //                 ),
            //                 Container(
            //                   decoration: BoxDecoration(
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(16)),
            //                     color: Colors.blue[100],
            //                   ),
            //                   width: 16,
            //                   height: 16,
            //                 ),
            //                 Container(
            //                   decoration: BoxDecoration(
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(16)),
            //                     color: Colors.blue[100],
            //                   ),
            //                   width: 16,
            //                   height: 16,
            //                 ),
            //                 Container(
            //                   decoration: BoxDecoration(
            //                     borderRadius:
            //                         BorderRadius.all(Radius.circular(16)),
            //                     color: Colors.blue[100],
            //                   ),
            //                   width: 16,
            //                   height: 16,
            //                 ),
            //               ],
            //             ),
            //             Spacer(),
            //           ],
            //         ),
            //
            //         SizedBox(
            //           height: 8,
            //         ),
            //
            //         Text("What's your focus?"),
            //
            //         SizedBox(
            //           height: 8,
            //         ),
            //
            //         Container(
            //           padding: EdgeInsets.all(16),
            //           child: TextField(
            //             decoration: InputDecoration(
            //               border: OutlineInputBorder(),
            //             ),
            //           ),
            //         ),
            //
            //         // Spacer(),
            //
            //         // clock timer garphics
            //         SizedBox(
            //           height: 200,
            //           child: AspectRatio(
            //             aspectRatio: 1,
            //             child: Padding(
            //               padding: const EdgeInsets.all(16.0),
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(500),
            //                   color: Colors.redAccent.shade100,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //
            //         // timer labels
            //         Text("45:00"),
            //         Text("session interval"),
            //
            //         // interval display
            //         Container(
            //           padding: EdgeInsets.all(8),
            //           decoration: BoxDecoration(
            //             border: Border.all(
            //               color: Colors.grey,
            //               width: 1,
            //             ),
            //             borderRadius: BorderRadius.circular(32),
            //           ),
            //           child: Row(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               // start time
            //               Text("11:15"),
            //               SizedBox(
            //                 width: 8,
            //               ),
            //               // arrow visual
            //               Icon(Icons.arrow_right_alt),
            //               SizedBox(
            //                 width: 8,
            //               ),
            //               // end time
            //               Text("12:00"),
            //             ],
            //           ),
            //         ),
            //         // Spacer(),
            //
            //         SizedBox(
            //           height: 16,
            //         ),
            //         // start session button
            //         FilledButton(
            //           onPressed: () {},
            //           child: Text("START SESSION"),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // right side pane
            // Expanded(
            //   child: Column(
            //     children: [
            //       // date view
            //       DatePicker(
            //         daysCount: 10,
            //         DateTime.now(),
            //         initialSelectedDate: DateTime.now(),
            //         selectionColor: Colors.black,
            //         selectedTextColor: Colors.white,
            //         onDateChange: (date) {
            //           setState(() {
            //             _selectedDate = date;
            //           });
            //         },
            //         height: 90,
            //         animateToSelection: true,
            //         width: 80,
            //         locale: "en_us",
            //       ),
            //
            //       // Header labels
            //       Text("Tuesday, 7 November"),
            //
            //       // timetable
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
