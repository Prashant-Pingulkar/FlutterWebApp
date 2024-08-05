import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'widgets/layout.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home:Scaffold(
        appBar:AppBar(
          backgroundColor:Colors.green[100]
        ),
        body:Layout()
      ),
      theme:ThemeData(
          dataTableTheme:DataTableThemeData(
            dataRowColor: WidgetStateProperty.resolveWith<Color>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected))
                  return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                return Color(0xFFf4f6f3);
              },
            ),
            decoration: BoxDecoration(color: Colors.white),
            dividerThickness: 1,
          )
      )
    );
  }
}



