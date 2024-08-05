import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '/utilities/breed.dart';
import '/services/http_request.dart';
import 'shimmer.dart';

class ImageCarouselSlider extends StatefulWidget {
  @override
  _ImageCarouselSliderState createState() => _ImageCarouselSliderState();
}

class _ImageCarouselSliderState extends State<ImageCarouselSlider> {
  late CarouselController _carouselController;
  late Future<List<Breed>> _dataSourceFuture;
  int currentPage = 0;
  int rowsPerPage=10;
  HttpRequest httpRequest=HttpRequest();

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
    _dataSourceFuture = httpRequest.fetchBreeds(currentPage,rowsPerPage);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Breed>>(
        future: _dataSourceFuture,
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ShimmerUi();
        } else if (snapshot.hasError) {
          return Center(child: Text('dError: ${snapshot}'));
        } else if (!snapshot.hasData) {
          return Center(child: Text('No data available'));
        } else {
          List<Breed> response = snapshot.data!;
          return LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  CarouselNavigator(_carouselController),
                  SizedBox(height:10),
                  CarouselSlider(
                    carouselController: _carouselController,
                    options:CarouselOptions(
                      height:310,
                      aspectRatio:16/9,
                      viewportFraction: 0.2,
                      initialPage: 1,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: false,
                      enlargeFactor: 0,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: response.map((breed) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Card(
                            elevation:0,
                            color:Colors.white,
                            child:Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[200]!, // Border color
                                  width: 0.5, // Border width
                                ),
                                borderRadius: BorderRadius.circular(5), // Border radius for rounded corners
                              ),
                              child:Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children:[
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                                      child:Container(height:150,width:double.infinity,child:Image.network(breed.url,fit: BoxFit.cover),),
                                    ),
                                    CardContent(breed)
                                  ]
                              ),
                            ),
                          );

                        },
                      );
                    }).toList(),
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }
}

class CardContent extends StatelessWidget {
  final  breeds;
  CardContent(this.breeds);
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child:Padding(
            padding:EdgeInsets.all(10),
            child:Expanded(
                child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children:[
                      Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children:[
                            Text(breeds.name,
                                style:TextStyle(
                                  fontSize:15,
                                  fontWeight:FontWeight.bold
                                )),
                            Text(
                                breeds.bredFor??'',
                              style:TextStyle(
                                fontSize:12,
                                color:Colors.grey[600]
                              )
                            )
                          ]
                      ),
                      Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children:[
                            Text(
                                breeds.lifeSpan,
                              style:TextStyle(
                                fontSize:12,
                                  color:Colors.grey
                              )

                            ),
                            Text(
                                breeds.temperament,
                                    style:TextStyle(
                                fontSize:12

                            )
                            )
                          ]
                      )
                    ]
                )
            )
        )
    );
  }
}


class CarouselNavigator extends StatelessWidget {
  late CarouselController _carouselController;

  CarouselNavigator(this._carouselController);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 200,
      child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children:[
            const Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children:[
                  Text('Dog Breeds',
                      style:TextStyle(
                          fontSize:20,
                          fontWeight:FontWeight.bold,
                          color:Color(0xFF616161)
                      )
                  ),
                  Text('Everyday is a Dog Day',
                      style:TextStyle(
                          fontSize:12,
                          fontWeight:FontWeight.w900,
                        color:Colors.grey
                      ))
                ]
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
                  onPressed: () {
                    _carouselController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
                  onPressed: () {
                    _carouselController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                ),
              ],
            )
          ]
      ),
    );
  }
}

