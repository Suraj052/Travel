import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ScrollController _scrollController = ScrollController();
  double _scrollPosition = 0;

  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<DataProvider>(context,listen: false).readJson();
    });
    _scrollController.addListener(_scrollListener);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: Color(0xFF40cde8),
            title: Center(child:Text("Hope to Happiness")),
            pinned: false,
            elevation: 10,
            expandedHeight: 60,
            leadingWidth: 50,
            leading: Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
              child:CircleAvatar(
                radius: 5,
                backgroundColor: Colors.white,
                child: Icon(Icons.arrow_back_ios_new_rounded,size:20,color: Colors.black))),
            actions: [
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child:CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.search,size:25,color: Colors.black))),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Consumer<DataProvider>(
                  builder: (context,value,child)
                      {
                        if(value.isLoading)
                          {
                            return const Center( child: CircularProgressIndicator(color: Color(0xFF091945)));
                          }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            scrollcard(size,value.bannerImages),
                            Padding(
                              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                              child: Container(
                                child: Row(
                                  children: [
                                    Icon(Icons.star_rounded,color: Colors.amber,size: 30),
                                    Icon(Icons.star_rounded,color: Colors.amber,size: 30),
                                    Icon(Icons.star_rounded,color: Colors.amber,size: 30),
                                    Icon(Icons.star_rounded,color: Colors.amber,size: 30),
                                    Icon(Icons.star_rounded,color: Colors.amber,size: 30),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                              child: Text(value.description,maxLines: 4,
                                  style: TextStyle(wordSpacing:2,color: Colors.grey.withOpacity(0.7),fontWeight: FontWeight.w400,fontFamily: 'ProductSans',fontSize: 18.0)),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                              child: Container(
                                height : size.height*0.25,
                                  child: Column(
                                    children: [
                                    ListTile(
                                          leading: Text('•',
                                            style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontFamily: 'ProductSans',fontSize: 24.0),
                                          ),
                                          title: Text(value.details[0],
                                            style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontFamily: 'ProductSans',fontSize: 18.0),
                                          ),
                                        ),
                                      ListTile(
                                        leading: Text('•',
                                          style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontFamily: 'ProductSans',fontSize: 24.0),
                                        ),
                                        title: Text(value.details[1],
                                          style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontFamily: 'ProductSans',fontSize: 18.0),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Text('•',
                                          style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontFamily: 'ProductSans',fontSize: 24.0),
                                        ),
                                        title: Text(value.details[2],
                                          style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400,fontFamily: 'ProductSans',fontSize: 18.0),
                                        ),
                                      ),
                                    ],
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Text("Popular Treks",
                                    style: TextStyle(wordSpacing:2,color: Colors.black,fontWeight: FontWeight.w500,fontFamily: 'ProductSans',fontSize:20.0)),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(5, 5, 15, 0),
                              height : size.height*0.25,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: (value.popularTreks.length/3).ceil(),
                                itemBuilder: (BuildContext context, int index) {
                                  int minIndex = index * 3;
                                  int maxIndex = (index + 1) * 3 - 1;
                                  maxIndex = maxIndex.clamp(0, value.popularTreks.length - 1);
                                  return Row(
                                    children: [
                                      for (int i = minIndex; i <= maxIndex; i++)
                                        TrekCard(size, value.popularTreks[i]["title"], value.popularTreks[i]["thumbnail"])
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      }
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }

  int active = 0;
  Widget scrollcard(Size size, List imageLink)
  {
    return Center(
      child: Container(
        width: size.width,
        height: size.height*0.3,
        child:
        Stack(
          children: [
            CarouselSlider.builder(
              itemCount: imageLink.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  Container(
                    height: size.height*0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(imageLink[itemIndex]),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
              options: CarouselOptions(
                height: 250,
                aspectRatio: 4/3,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: _scrollPosition ==0 ? true : false,
                onPageChanged: (index, reason) {
                  setState(() {
                    active = index;
                  });
                },
                autoPlayInterval: Duration(seconds: 1),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                scrollDirection: Axis.horizontal,

              ),
            ),
            SizedBox(height: 5),
            Positioned(
              bottom: 10,
              left: 1,
              right: 1,
              child: DotsIndicator(
                dotsCount: imageLink.length,
                position: active,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget TrekCard(Size size,String placeName,String imageUrl)
  {
    return Container(
      margin: EdgeInsets.all(10),
      height: size.height*0.22,
      width: size.width*0.35,
      child: Stack(
        children: [
          Container(
            height: size.height*0.22,
            width: size.width*0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8,0, 0, 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(placeName,
                        style: TextStyle(wordSpacing:2,color: Colors.white,fontWeight: FontWeight.w200,fontFamily: 'ProductSans',fontSize:13.0)),
                    Container(
                      margin: EdgeInsets.only(top: 1),
                      child: Row(
                        children: [
                          Icon(Icons.star_rounded,color: Colors.amber,size: 15),
                          Icon(Icons.star_rounded,color: Colors.amber,size: 15),
                          Icon(Icons.star_rounded,color: Colors.amber,size: 15),
                          Icon(Icons.star_rounded,color: Colors.amber,size: 15),
                          Icon(Icons.star_rounded,color: Colors.white,size: 15),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          )

        ],
      ),
    );

  }

}
