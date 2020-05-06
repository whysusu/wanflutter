import 'package:wanflutter/http/api_request.dart';
import 'package:wanflutter/provider/view_state_list_model.dart';
import 'package:wanflutter/provider/view_state_refresh_list_model.dart';

class ProjectTreeModel extends ViewStateListModel {
  @override
  Future<List> loadData({int pageNum}) async {
    return await APIRequest.getProjiectTree();
  }
}

class ProjectListModel extends ViewStateRefreshListModel {
  int cid;

  ProjectListModel(this.cid);

  @override
  Future<List> loadData({int pageNum}) async {
    if(pageNum==0||pageNum==1){
      currentPageNum = 1;
    }
    return await APIRequest.getProjiecList(pageNum, cid);
  }
}
