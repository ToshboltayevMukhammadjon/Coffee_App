import 'package:coffe_app/coffee_data/coffe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 200);
const _initialPage = 8.0;

class CoffeeConceptList extends StatefulWidget {
  const CoffeeConceptList({Key? key}) : super(key: key);

  @override
  _CoffeeConceptListState createState() => _CoffeeConceptListState();
}

class _CoffeeConceptListState extends State<CoffeeConceptList> {
  final _pageCoffeeController = PageController(
    viewportFraction: 0.35,
    initialPage: _initialPage.toInt()
  );
  final _pageTextController = PageController(initialPage: _initialPage.toInt());
  double _currentPage = _initialPage;
  double _textPage = _initialPage;

  void _coffeeScrollListener() {
    setState(() {
      _currentPage = _pageCoffeeController.page!;
    });
  }

  void _textScrollListener() {
    _textPage = _currentPage;
  }

  @override
  void initState() {
    _pageCoffeeController.addListener(_coffeeScrollListener);
    _pageTextController.addListener(_textScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageCoffeeController.removeListener(_coffeeScrollListener);
    _pageCoffeeController.dispose();
    _pageTextController.removeListener(_textScrollListener);
    _pageTextController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 20,
            right: 20,
            bottom: -size.height * 0.22,
            height: size.height * 0.3,
            child: DecoratedBox(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.brown, blurRadius: 90, spreadRadius: 45),
              ]),
            ),
          ),
          Transform.scale(
            scale: 1.6,
            alignment: Alignment.bottomCenter,
            child: PageView.builder(
                controller: _pageCoffeeController,
                scrollDirection: Axis.vertical,
                itemCount: coffees.length + 1,
                onPageChanged: (value) {
                  if (value < coffees.length) {
                    _pageTextController.animateToPage(
                      value,
                      duration: _duration,
                      curve: Curves.easeOut,
                    );
                  }
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }
                  final coffee = coffees[index - 1];
                  final result = _currentPage - index + 1;
                  final value = -0.4 * result + 1;
                  final opacity = value.clamp(0.0, 1.0);
                  print(result);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..translate(
                          0.0,
                          MediaQuery.of(context).size.height /
                              2.6 *
                              (1 - value).abs(),
                        )
                        ..scale(value),
                      child: Opacity(
                        opacity: opacity,
                        child: Hero(
                          tag: coffee.name,
                          child: Image.asset(
                            coffee.image,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Positioned(
            left: 0,
            top: 0,
            right: 0,
            height: 100,
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemCount: coffees.length,
                    controller: _pageTextController,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final opacity =
                          (1 - (index - _textPage).abs()).clamp(0.0, 1.0);
                      return Opacity(
                          opacity: opacity,
                          child: GestureDetector(
                            onTap: (){},
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: size.width*0.2),
                              child: Text(
                                coffees[index].name,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),);
                    },
                  ),
                ),
                AnimatedSwitcher(
                  duration: _duration,
                  child: Text(
                      "${coffees[_currentPage.toInt()].price} so'm",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                    key: Key(coffees[_currentPage.toInt()].name),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
