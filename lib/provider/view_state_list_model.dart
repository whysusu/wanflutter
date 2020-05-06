import 'package:wanflutter/http/api_request.dart';
import 'package:wanflutter/provider/view_state_model.dart';

abstract class ViewStateListModel<T> extends ViewStateModel {
  List<T> list = [];



  ///初始化数据模型(首次进入页面会调用此方法)
  initData() async {
    setBusy(true);
    await refresh(init: true);
  }


  //刷新
  refresh({bool init = false}) async {
    try {
      List<T> data = await loadData();
      if (data.isEmpty) {
        setEmpty();
      } else {
        onCompleted(data);
        list = data;
        if (init) {
          setBusy(false);
        } else {
          notifyListeners();
        }
      }
    } catch (e, s) {
      handleCatch(e, s);
      print("cx---错误" + e.toString());
    }
  }

  // 加载数据
  Future<List<T>> loadData({int pageNum});


  onCompleted(List<T> data) {}

}
