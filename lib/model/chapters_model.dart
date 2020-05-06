import 'package:wanflutter/http/api_request.dart';
import 'package:wanflutter/provider/view_state_list_model.dart';
import 'package:wanflutter/provider/view_state_refresh_list_model.dart';

class ChaptersModel extends ViewStateListModel {
  @override
  Future<List> loadData({int pageNum}) async {
    return await APIRequest.getChapters();
  }
}


class ChaptersListModel extends ViewStateRefreshListModel{
  int id;
  ChaptersListModel(this.id);
  @override
  Future<List> loadData({int pageNum}) async{
    if(pageNum==0||pageNum==1){
      currentPageNum=1;
    }
    return await APIRequest.getChapterList(pageNum, id);
  }

}