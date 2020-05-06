import 'package:flutter/cupertino.dart';

class TopToTopModel with ChangeNotifier {
  ScrollController _scrollController;

  ScrollController get scrollController => _scrollController;
  double _height;
  double offset =0.0;
  bool _showTopBtn = false;

  bool get showTopBtn => _showTopBtn;

  TopToTopModel(this._scrollController, {double height: 120}) {
    _height = height;
  }

  init() {
    _scrollController.addListener(() {
      // ignore: invalid_use_of_protected_member
      offset = _scrollController.positions.elementAt(0).pixels;//这里获取列表组合中的第一个来计算偏移量
//      offset=_scrollController.offset;//若列表组合中只有一个子列表，就可用该方法获取偏移量
      try {
        if (offset > _height && !_showTopBtn) {
          _showTopBtn = true;
          notifyListeners();
        } else if (offset < _height && _showTopBtn) {
          _showTopBtn = false;
          notifyListeners();
        }
      } catch (e) {
        if (e is Exception) {
          print(e.toString());
        }
      }
    });
  }

  scrollToTop() {
    _scrollController.animateTo(0,
//        duration: Duration(milliseconds: 300), curve: Curves.easeInOutCubic);
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
