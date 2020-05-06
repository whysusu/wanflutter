import 'package:wanflutter/entity/article_bean_entity.dart';
import 'package:wanflutter/entity/article_top_bean_entity.dart';
import 'package:wanflutter/entity/banner_bean_entity.dart';
import 'package:wanflutter/entity/project_list_entity.dart';
import 'package:wanflutter/entity/project_tree_entity_entity.dart';
import 'package:wanflutter/entity/system_bean_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "ArticleBeanEntity") {
      return ArticleBeanEntity.fromJson(json) as T;
    } else if (T.toString() == "ArticleTopBeanEntity") {
      return ArticleTopBeanEntity.fromJson(json) as T;
    } else if (T.toString() == "BannerBeanEntity") {
      return BannerBeanEntity.fromJson(json) as T;
    } else if (T.toString() == "ProjectListEntity") {
      return ProjectListEntity.fromJson(json) as T;
    } else if (T.toString() == "ProjectTreeEntityEntity") {
      return ProjectTreeEntityEntity.fromJson(json) as T;
    } else if (T.toString() == "SystemBeanEntity") {
      return SystemBeanEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}