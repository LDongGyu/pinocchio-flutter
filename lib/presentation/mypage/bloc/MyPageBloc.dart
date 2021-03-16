import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/mypage_response.dart';
import 'package:flutter_sancle/data/repository/mypage_repository.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageEvent.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageState.dart';

class MyPageBloc extends Bloc<MyPageEvent, MyPageState> {
  final MyPageRepository _myPageRepository;
  final StreamController _currentPageController = StreamController<int>();
  MyPageResponse _myPageResponse;

  int page;
  Stream<int> _currentPageStream;

  final _pageController = PageController();

  MyPageBloc(this._myPageRepository) : super(MyPageInit());

  @override
  Stream<MyPageState> mapEventToState(MyPageEvent event) async* {
    // TODO: implement mapEventToState
    if (event is MyPageSlide) {
      page = event.page;
      _pageController.jumpToPage(page);
      _currentPageController.add(page);
    }

    if (event is GetInfo){
      _myPageResponse = await _myPageRepository.getMyClothInfo();

      yield GetSuccess();
    }
  }

  Stream<int> get currentPage => _currentPageStream;

  get pageController => _pageController;

  get myPageResponse => _myPageResponse;
}