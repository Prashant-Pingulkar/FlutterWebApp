import 'package:flutter/material.dart';
import 'carousel_slider.dart';
import 'table_container.dart';

class Layout extends StatefulWidget {
  @override
  _LayoutState createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            scrollDirection:Axis.vertical,
            child: Container(
                padding:EdgeInsets.symmetric(vertical:30,horizontal:40),
                child:Column(
                    children:[
                      ImageCarouselSlider(),
                      SizedBox(height:20),
                      TableContainer()
                    ]
                )
            ),
          ),
        )
    );
  }
}



