import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageBloc.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageState.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'bloc/MyPageEvent.dart';

class MyPageScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<MyPageBloc>(
              create: (context) {
                return MyPageBloc()..add(MyPageInitial());
              },
              child: MyPageScreen(),
            ));
  }

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<MyPageBloc, MyPageState>(
      listener: (context, state) {
        if (state is MyPageStart) {}
      },
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Container(
            color: buttonDisableColor,
            child: Column(
              children: <Widget>[
                SizedBox(height: getProportionateScreenHeight(64)),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: getProportionateScreenWidth(30)),
                  child: SvgPicture.asset("assets/icons/back_button.svg"),
                ),
                SizedBox(height: getProportionateScreenHeight(36)),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: getProportionateScreenWidth(30)),
                      height: getProportionateScreenHeight(96),
                      child: PageView.builder(
                          controller:
                              BlocProvider.of<MyPageBloc>(context).pageController,
                          itemCount: _prompt.length,
                          onPageChanged: (page) {
                            BlocProvider.of<MyPageBloc>(context)
                                .add(MyPageSlide(page));
                          },
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: getProportionateScreenWidth(30),
                                ),
                                Container(
                                  child: Image.asset(
                                      'assets/images/mypage_illust.png',
                                      height: getProportionateScreenHeight(94)),
                                ),
                                Expanded(child: Container()),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(height: getProportionateScreenHeight(19.0)),
                                    Text(
                                      _prompt[index][0],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(21),
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'nanum_square'),
                                    ),
                                    SizedBox(height: getProportionateScreenHeight(7.0)),
                                    Text(
                                      _prompt[index][1],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(21.0),
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'nanum_square'),
                                    ),
                                    SizedBox(height: getProportionateScreenHeight(9.0)),
                                    Text(
                                      _prompt[index][2],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(11.0),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'nanum_square'),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: getProportionateScreenWidth(30.0)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          for (int i = 0; i < _prompt.length; i++)
                            if (i == 1) ...[_circleBar(true)] else
                              _circleBar(false),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(18),
                ),
                Container(
                  padding: EdgeInsets.only(left: getProportionateScreenWidth(30), right: getProportionateScreenWidth(30)),
                  width: SizeConfig.screenWidth,
                  height: getProportionateScreenHeight(126),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor,
                            offset: Offset(1, 2),
                            blurRadius: 2)
                      ]),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: getProportionateScreenHeight(20)),
                          Text(
                            '라벨라벨라벨라님',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: getProportionateScreenHeight(20),
                                fontWeight: FontWeight.w800,
                                fontFamily: 'nanum_square'),
                          ),
                          SizedBox(height: 12),
                          Text(
                            '산클 옷장에 쌓인 옷',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: getProportionateScreenHeight(14),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'nanum_square'),
                          ),
                          SizedBox(height: 8),
                          Text.rich(TextSpan(
                              text: '12345678912345',
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(14),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'nanum_square'),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '벌!',
                                  style: TextStyle(
                                      fontSize: getProportionateScreenHeight(14),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'nanum_square'),
                                )
                              ])),
                        ],
                      ),
                      Expanded(child: Container()),
                      Image.asset(
                        'assets/images/default_profile.png',
                        height: getProportionateScreenHeight(78),
                        width: getProportionateScreenWidth(78),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(18),
                ),
                Container(
                  padding: EdgeInsets.only(left: getProportionateScreenWidth(30), top: getProportionateScreenHeight(30), right: getProportionateScreenWidth(30)),
                  width: SizeConfig.screenWidth,
                  height: getProportionateScreenHeight(286),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor,
                            offset: Offset(1, 2),
                            blurRadius: 2)
                      ]),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '판별한 의류',
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(18),
                              fontWeight: FontWeight.w800,
                              fontFamily: 'nanum_square'),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Container(
                          height: 188,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: 5,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                child: Column(
                                  children: [
                                    SvgPicture.asset(
                                      _category[index][0],
                                      height: 60,
                                      width: 60,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(_category[index][1],
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(14),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'nanum_square'))
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(18)),
                Container(
                  height: getProportionateScreenHeight(62),
                  padding: EdgeInsets.only(left: getProportionateScreenWidth(30)),
                  alignment: Alignment.centerLeft,
                  child: Text('공지사항',
                      style: TextStyle(
                          fontSize:
                          getProportionateScreenHeight(18),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'nanum_square')),
                ),
                SizedBox(height: getProportionateScreenHeight(6)),
                Container(
                  height: getProportionateScreenHeight(62),
                  padding: EdgeInsets.only(left: getProportionateScreenWidth(30)),
                  alignment: Alignment.centerLeft,
                  child: Text('자주 묻는 질문',
                      style: TextStyle(
                          fontSize:
                          getProportionateScreenHeight(18),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'nanum_square')),
                ),
                SizedBox(height: getProportionateScreenHeight(6)),
                Container(
                  height: getProportionateScreenHeight(62),
                  padding: EdgeInsets.only(left: getProportionateScreenWidth(30)),
                  alignment: Alignment.centerLeft,
                  child: Text('로그아웃',
                      style: TextStyle(
                          fontSize:
                          getProportionateScreenHeight(18),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'nanum_square')),
                ),
                SizedBox(height: getProportionateScreenHeight(46)),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget _circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 3),
      height: getProportionateScreenHeight(4),
      width: isActive
          ? getProportionateScreenWidth(14)
          : getProportionateScreenWidth(4),
      decoration: BoxDecoration(
          color: isActive ? primaryColor : textDisableColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  List<List<String>> _prompt = [
    [
      '최대 10글자로 타이틀',
      '총 2줄로 어때요?',
      '클릭해서 확인해보세요-!',
    ],
    [
      '최대 10글자로 타이틀',
      '총 2줄로 어때요?',
      '클릭해서 확인해보세요-!',
    ],
    [
      '최대 10글자로 타이틀',
      '총 2줄로 어때요?',
      '클릭해서 확인해보세요-!',
    ]
  ];

  List<List<String>> _category = [
    ['assets/icons/top.svg', '상의'],
    ['assets/icons/pants.svg', '하의'],
    ['assets/icons/socks.svg', '양말'],
    ['assets/icons/underwear.svg', '속옷'],
    ['assets/icons/towel.svg', '수건'],
  ];
}
