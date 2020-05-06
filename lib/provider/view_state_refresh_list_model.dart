import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wanflutter/provider/view_state_list_model.dart';

abstract class ViewStateRefreshListModel<T> extends ViewStateListModel {
  static const int pageNumFirst = 0;
  static const int pageSize = 20;
  int currentPageNum = pageNumFirst;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController get refreshController => _refreshController;

  ///刷新
  @override
  Future<List<T>> refresh({bool init = false}) async {
    try {
      currentPageNum = pageNumFirst;
      var data = await loadData(pageNum: pageNumFirst);
      if (data.isEmpty) {
        setEmpty();
      } else {
        list.clear();
        list.addAll(data);
        refreshController.refreshCompleted();
        if (list.length < 10) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        if (init) {
          setBusy(false);
        } else {
          notifyListeners();
        }
      }
      return data;
    } catch (e, s) {
      handleCatch(e, s);
      if(list.length<=0){
        setError("数据加载失败了");
      }else{
        setBusy(false);
      }
      print("cx---错误" + e.toString());
      currentPageNum--;
      refreshController.refreshFailed();
      Fluttertoast.showToast(
          msg: "刷新失败了",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
//          backgroundColor: Colors.blue[10],
//          textcolor: '#ffffff'
      );
      return null;
    }
  }

  ///加载更多
  Future<List<T>> loadMore() async {
    try {
      var data = await loadData(pageNum: ++currentPageNum);
      if (data.isEmpty) {
        currentPageNum--;
        refreshController.loadNoData();
      } else {
        onCompleted(data);
        list.addAll(data);
        if (list.length < 20) {
          refreshController.loadNoData();
        } else {
          refreshController.loadComplete();
        }
        notifyListeners();
      }
      return data;
    } catch (e, s) {
      print("cx---错误" + e.toString());
      refreshController.loadFailed();
      Fluttertoast.showToast(
        msg: "刷新失败了",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
//          backgroundColor: Colors.blue[10],
//          textcolor: '#ffffff'
      );
      return null;
    }
  }

  Future<List> loadData({int pageNum});

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
