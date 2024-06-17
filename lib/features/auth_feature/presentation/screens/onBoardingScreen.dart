import 'package:aid_robot/features/auth_feature/presentation/screens/role.dart';
import 'package:flutter/material.dart';

import '../../../../app/widgets/image_widget.dart';
import '../../../../app/widgets/text_widget.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({Key? key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  late int selectedPage;
  late final PageController _pageController;

  @override
  void initState() {
    selectedPage = 0;
    _pageController = PageController(initialPage: selectedPage);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    const int pageCount = 3 ; // تعريف قيمة pageCount
    int _selectedValue = 1;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  selectedPage = page;
                });
              },
              children: List.generate(pageCount, (index) {
                return _buildPage(index);
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: PageViewDotIndicator(
              currentItem: selectedPage,
              count: pageCount,
              unselectedColor: Colors.black26,
              selectedColor: Colors.blue,
              duration: const Duration(milliseconds: 200),
              boxShape: BoxShape.rectangle,
              onItemClicked: (index) {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
                setState(() {
                  selectedPage = index;
                });
              },
              pageController: _pageController,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  children: [
                    TextWidget(
                      title: ' Skip',
                      titleColor: Colors.grey,
                      titleSize: 20,
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if (selectedPage < pageCount - 1) {
                          _pageController.animateToPage(
                            selectedPage + 1,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          );
                          setState(() {
                            selectedPage++;
                          });
                        }
                      },
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  RolePage(),));
                        },
                        child: TextWidget(
                          title: 'Next',
                          titleColor: Colors.blue,
                          titleSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    late String title;
    late String subTitle;
    late String imageUrl;

    switch (index) {
      case 0:
        title = 'Seamless Doctor';
        subTitle = 'Connections';
        imageUrl = 'assets/images/im1.png';
        break;
      case 1:
        title = 'Medications at Your';
        subTitle = 'Doorstep';
        imageUrl = 'assets/images/im2.png';
        break;
    default:
        title = 'Find Pharmacies';
        subTitle = 'Nearby';
        imageUrl = 'assets/images/im3.png';
        break;
      /*default:
        title = 'Tailor Your Experience';
        subTitle = '';
        imageUrl = 'assets/images/logo4.png';*/
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(100.0),
              child: ImageWidget(
                imageUrl: imageUrl,width: 200,height: 200,

              ),
            ),
          ],
        ),
        SizedBox(height: 50),
        TextWidget(
          title: title,
          titleColor: Colors.black,
          titleFontWeight: FontWeight.bold,
          titleSize: 35,
        ),
        TextWidget(
          title: subTitle,
          titleColor: Colors.black,
          titleFontWeight: FontWeight.bold,
          titleSize: 35,
        ),
        TextWidget(
          title: 'To provide you  with good ',
          titleColor: Colors.grey,
          titleSize: 23,
        ),
        TextWidget(
          title: 'experience, please select your ',
          titleColor: Colors.grey,
          titleSize: 23,
        ),
        TextWidget(
          title: 'role below:.',
          titleColor: Colors.grey,
          titleSize: 23,
        ),
      ],
    );
  }
}

class PageViewDotIndicator extends StatelessWidget {
  final int currentItem;
  final int count;
  final Color unselectedColor;
  final Color selectedColor;
  final Duration duration;
  final BoxShape boxShape;
  final Function(int)? onItemClicked;
  final PageController pageController;

  PageViewDotIndicator({
    required this.currentItem,
    required this.count,
    this.unselectedColor = Colors.grey,
    this.selectedColor = Colors.blue,
    this.duration = const Duration(milliseconds: 200),
    this.boxShape = BoxShape.circle,
    this.onItemClicked,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return InkWell(
          onTap: () {
            if (onItemClicked != null) {
              onItemClicked!(index);
            }
          },
          child: AnimatedContainer(
            duration: duration,
            margin: EdgeInsets.symmetric(horizontal: 8),
            height: 8,
            width: currentItem == index ? 24 : 8,
            decoration: BoxDecoration(
              shape: boxShape,
              color: currentItem == index ? selectedColor : unselectedColor,
            ),
          ),
        );
      }),
    );
  }
}
