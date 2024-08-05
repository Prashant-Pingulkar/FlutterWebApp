import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class ShimmerUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          Container(
              padding:EdgeInsets.symmetric(vertical:10,horizontal:10),
              child:Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:CrossAxisAlignment.end,
                  children:[
                ShimmerContainer(50,100,EdgeInsets.only(bottom:0)),
                ShimmerContainer(30,50,EdgeInsets.only(bottom:0)),
              ]
            )
          ),
          Container(
            child: SingleChildScrollView(
              scrollDirection:Axis.horizontal,
              child: Row(
                children:[1,2,3,4,5,6,7,8].map((item) {
                  return Container(
                    padding:EdgeInsets.symmetric(vertical:0,horizontal:10),
                    child: Column(
                        children:[
                          ShimmerContainer(150,200,EdgeInsets.only(bottom:10)),
                          ShimmerContainer(30,200,EdgeInsets.only(bottom:20)),
                          ShimmerContainer(30,200,EdgeInsets.only(bottom:20))

                        ]
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  final double height;
  final double width;
  final EdgeInsetsGeometry padding;

  ShimmerContainer(this.height,this.width,this.padding);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0), // Rounded corners
          color:Colors.white,
      ),
      height:height,
      width:width,
    );
  }
}

