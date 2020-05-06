import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

enum ViewState { empty, busy, idle, error, unAuthorized }

class ViewStateModel with ChangeNotifier {
  bool disposed=false;
  ViewState _viewState;

  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  //??判空赋值运算符
  ViewStateModel({ViewState viewState}) : _viewState = viewState ?? ViewState.idle;

  setBusy(bool value) {
    viewState = value ? ViewState.busy : ViewState.idle;
  }

  setEmpty() {
    viewState = ViewState.empty;
  }

  setError(message) {
    viewState = ViewState.error;
  }



  ///数据刷新的核心方法，该方法会在接口返回后更改页面状态的同时去调用，不用在每个页面调用setState来进行数据刷新
  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  void handleCatch(e, s) {
//    if (e is DioError && e.error is UnAuthorizedException) {
//    } else {
//      debugPrint('error--->\n' + e.toString());
//      debugPrint('statck--->\n' + s.toString());
//      setError(e is Error ? e.toString() : e.message);
//    }

    debugPrint('error--->\n' + e.toString());
    debugPrint('statck--->\n' + s.toString());
    setError(e is Error ? e.toString() : e.message);
  }
}
