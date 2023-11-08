import 'package:flutter/material.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // pomos counter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 56,
                      ),
                      PomoIndicator(
                        isDone: true,
                      ),
                      PomoIndicator(
                        isDone: true,
                      ),
                      PomoIndicator(
                        isDone: true,
                      ),
                      PomoIndicator(
                        isDone: true,
                      ),
                      PomoIndicator(),
                      PomoIndicator(),
                      PomoIndicator(),
                      PomoIndicator(),
                      PomoIndicator(),
                      PomoIndicator(),
                      PomoIndicator(),
                      PomoIndicator(),
                      PomoIndicator(),
                      PomoIndicator(),
                      SizedBox(
                        width: 56,
                      ),
                    ],
                  ),

                  // focus widget
                  Text("What's your focus?"),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade200,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        filled: true,
                        hintText: "Intention for this Session",
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}

class PomoIndicator extends StatelessWidget {
  const PomoIndicator({
    super.key,
    isDone = false,
  });

  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDone! ? Colors.red.shade100 : Colors.blueGrey,
        borderRadius: BorderRadius.circular(32),
      ),
      width: 16,
      height: 16,
    );
  }
}
