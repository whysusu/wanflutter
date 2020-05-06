
import 'package:wanflutter/entity/article_top_bean_entity.dart';
import 'package:wanflutter/entity/banner_bean_entity.dart';
import 'package:wanflutter/http/api_request.dart';
import 'package:wanflutter/provider/view_state_refresh_list_model.dart';

class HomeModel extends ViewStateRefreshListModel {
  List<BannerBeanData> _banners;
  List<ArticleTopBeanData> _article;

  List<BannerBeanData> get banners => _banners;
  List<ArticleTopBeanData> get article => _article;

  @override
  Future<List> loadData({int pageNum}) async {
    List<Future> futuers = [];
    if (pageNum == 0) {
      futuers.add(APIRequest.getBanner());
      futuers.add(APIRequest.getArticleTop());
    }
    futuers.add(APIRequest.getArticle(pageNum));
    var results = await Future.wait(futuers);
    if (pageNum == 0) {
      _banners = results[0];
      _article = results[1];
      return results[2];
    } else {
      return results[0];
    }
  }
}
