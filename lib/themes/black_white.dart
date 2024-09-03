// Light Theme
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  //accentColor: Colors.blueAccent,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  ).copyWith(secondary: Colors.blue),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: _buildTextTheme(Brightness.light),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    labelStyle: TextStyle(color: Colors.black54),
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.all(Colors.blue),
  ),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: _buildTextTheme(Brightness.dark),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: Colors.lightBlue,
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    labelStyle: TextStyle(color: Colors.white70),
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.all(Colors.lightBlue),
  ),
  colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue, brightness: Brightness.dark)
      .copyWith(secondary: Colors.lightBlue),
);

TextTheme _buildTextTheme(Brightness brightness) {
  Color textColor =
      brightness == Brightness.light ? Colors.black : Colors.white;
  return TextTheme(
    displayLarge: TextStyle(
        fontSize: 30.0, fontWeight: FontWeight.bold, color: textColor),
    bodyLarge: TextStyle(
        fontSize: 16.0, color: textColor.withOpacity(0.8)), // Paragraphs
    bodyMedium: TextStyle(
        fontSize: 14.0,
        color: textColor.withOpacity(0.7),
        fontStyle: FontStyle.italic), // Long text, easy read
    titleMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        color: textColor), // Titles
  );
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Custom Theme Example')),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text('Title', style: Theme.of(context).textTheme.displayLarge),
//               Text('This is a paragraph for easy reading.',
//                   style: Theme.of(context).textTheme.bodyLarge),
//               Text('This is for longer text, designed for focus.',
//                   style: Theme.of(context).textTheme.bodyMedium),
//               const TextField(
//                   decoration: InputDecoration(labelText: 'Enter text')),
//               ElevatedButton(onPressed: () {}, child: const Text('Submit')),
//               CheckboxListTile(
//                 title: const Text("Option"),
//                 value: false,
//                 onChanged: (bool? value) {},
//               ),
//               const Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text('This is a card'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
