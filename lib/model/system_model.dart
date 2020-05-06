import 'package:wanflutter/http/api_request.dart';
import 'package:wanflutter/provider/view_state_list_model.dart';

class SystemTreeModel extends ViewStateListModel{
  @override
  Future<List> loadData({int pageNum}) async{
    return await APIRequest.getSystemTree();
  }

}