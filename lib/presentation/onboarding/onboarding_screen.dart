import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/main/main_screen.dart';
import 'package:flutter_sancle/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter_sancle/presentation/onboarding/bloc/onboarding_event.dart';
import 'package:flutter_sancle/presentation/onboarding/bloc/onboarding_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class OnboardingScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<OnboardingBloc>(
        create: (context) {
          return OnboardingBloc()..add(OnboardingCheck());
        },
        child: OnboardingScreen(),
      )
    );
  }

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPageValue = 0;
  final _pageController = PageController();
  bool _isEnd = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<OnboardingBloc, OnboardingState>(
        listener: (context, state) {
          if (state is OnboardingGuided) {
            Navigator.pushReplacement(context, MainScreen.route());
          }
        },
        child: Column(
          children: <Widget>[_pageView(), _bottomView()],
        ),
      ),
    );
  }

  Widget _pageView() {
    return Expanded(
      flex: 6,
      child: Stack(
        children: <Widget>[
          Container(
            child: PageView.builder(
                controller: _pageController,
                itemCount: _onbordingList.length,
                onPageChanged: (page) {
                  _getChangedPageAndMoveBar(page);
                },
                itemBuilder: (context, index) {
                  return _onbordingList[index];
                }),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 59, right: 16),
              child: TouchableOpacity(
                activeOpacity: 0.6,
                onTap: () {
                  BlocProvider.of<OnboardingBloc>(context).add(OnboardingFinish());
                },
                child: Text(
                  '건너뛰기',
                  style: TextStyle(color: Color.fromRGBO(15, 16, 18, 1)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomView() {
    return Expanded(
      flex: 4,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(children: <Widget>[
            SizedBox(height: 20),
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      for (int i = 0; i < _onbordingList.length; i++)
                        if (i == _currentPageValue) ...[_circleBar(true)] else
                          _circleBar(false),
                    ],
                  ),
                  height: 20,
                ),
              ],
            ),
            SizedBox(height: 20),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _mainPrompt[_currentPageValue],
                        SizedBox(height: 24.0),
                        _subPrompt[_currentPageValue]
                      ]),
                )),
            Expanded(child: Container()),
            TouchableOpacity(
              activeOpacity: 0.6,
              onTap: () {
                if(_isEnd){
                  BlocProvider.of<OnboardingBloc>(context)
                      .add(OnboardingFinish());
                }
                if (_currentPageValue < 2) {
                  print('$_currentPageValue');
                  _getChangedPageAndMoveBar(_currentPageValue + 1);
                  _pageController.jumpToPage(_currentPageValue);
                }
                if (_currentPageValue == 2) {
                  _isEnd = true;
                }
              },
              child: Container(
                height: 52,
                width: _currentPageValue < 2 ? 120 : 142,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(
                      width: 0.5,
                      color: Color.fromRGBO(15, 16, 18, 0.4),
                    )),
                alignment: Alignment.center,
                child: Wrap(children: [
                  Row(mainAxisSize: MainAxisSize.min, children: [
                    SizedBox(width: 16),
                    Text(
                      '${_buttonPrompt[_currentPageValue]}',
                      style: TextStyle(
                        fontFamily: 'nanum_square',
                        fontWeight: FontWeight.w800,
                        color: Color.fromRGBO(15, 16, 18, 1),
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 16),
                    Container(
                      child: SvgPicture.asset(
                        'assets/icons/arrow_logo.svg',
                        height: 16,
                      ),
                    ),
                    SizedBox(width: 16),
                  ])
                ]),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ]),
        ),
      ),
    );
  }

  final List<Widget> _onbordingList = <Widget>[
    FittedBox(
        alignment: Alignment.topCenter,
        child: Image.asset('assets/images/onboarding_1.png'),
        fit: BoxFit.fill),
    FittedBox(
        alignment: Alignment.topCenter,
        child: Image.asset('assets/images/onboarding_2.png'),
        fit: BoxFit.fill),
    FittedBox(
        alignment: Alignment.topCenter,
        child: Image.asset('assets/images/onboarding_3.png'),
        fit: BoxFit.fill),
  ];

  Widget _circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
          color: isActive ? Color(0xFFF8D247) : Colors.white,
          border: Border.all(
            color: isActive ? Color(0xFFDFB10F) : Color(0xFFC4C4C4),
          ),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  final List<Widget> _mainPrompt = <Widget>[
    Text.rich(TextSpan(
        text: '옷 세탁법',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            fontFamily: 'nanum_square'),
        children: <TextSpan>[
          TextSpan(
            text: '이 궁금하세요?',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w300,
                fontFamily: 'nanum_square'),
          )
        ])),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(
            text: '찍힌 라벨',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                fontFamily: 'nanum_square'),
            children: <TextSpan>[
              TextSpan(
                text: '이',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'nanum_square'),
              )
            ])),
        SizedBox(
          height: 12,
        ),
        Text(
          '맞는지 확인해주세요',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
              fontFamily: 'nanum_square'),
        )
      ],
    ),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '보관함에 라벨을',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
              fontFamily: 'nanum_square'),
        ),
        SizedBox(
          height: 12,
        ),
        Text.rich(TextSpan(
            text: '저장',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                fontFamily: 'nanum_square'),
            children: <TextSpan>[
              TextSpan(
                text: '할 수 있어요',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'nanum_square'),
              )
            ])),
      ],
    ),
  ];

  final List<Widget> _subPrompt = <Widget>[
    Text('카메라 버튼을 눌러 라벨을 찍어보세요',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 16,
            fontFamily: 'nanum_square',
            fontWeight: FontWeight.w300)),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('산클에서 라벨 이미지를 분석하여',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'nanum_square',
                fontWeight: FontWeight.w300)),
        SizedBox(height: 10),
        Text('세탁법과 상세 정보를 알려준답니다!',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'nanum_square',
                fontWeight: FontWeight.w300)),
      ],
    ),
    Text('이전에 찍었던 라벨 정보를 다시 확인할 수 있어요',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 16,
            fontFamily: 'nanum_square',
            fontWeight: FontWeight.w300)),
  ];

  final List<String> _buttonPrompt = ['다음', '다음', '시작하기'];

  void _getChangedPageAndMoveBar(int page) {
    setState(() {
      _currentPageValue = page;
    });
  }
}
