import 'dart:convert';

import 'package:wanflutter/entity/article_bean_entity.dart';
import 'package:wanflutter/entity/article_top_bean_entity.dart';
import 'package:wanflutter/entity/banner_bean_entity.dart';
import 'package:wanflutter/entity/project_list_entity.dart';
import 'package:wanflutter/entity/project_tree_entity_entity.dart';
import 'package:wanflutter/entity/system_bean_entity.dart';
import 'package:wanflutter/http/http_manager.dart';

import 'api.dart';

///数据请求
class APIRequest {
  ///首页banner
  static Future getBanner() async {
    var response = await HttpManager.getInstance().dio.get(HttpUrls.bannerUrl);
    return BannerBeanEntity.fromJson(jsonDecode(response.toString())).data;
  }

  ///首页置顶列表
  static Future getArticleTop() async {
    var response =
        await HttpManager.getInstance().dio.get(HttpUrls.articleTopUrl);
    return ArticleTopBeanEntity.fromJson(jsonDecode(response.toString())).data;
  }

  ///首页普通列表
  static Future getArticle(int pageNum) async {
    var response = await HttpManager.getInstance()
        .dio
        .get(HttpUrls.articleUrl + pageNum.toString() + "/json");
    return ArticleBeanEntity.fromJson(jsonDecode(response.toString()))
        .data
        .datas;
  }

  ///项目分类
  static Future getProjiectTree() async {
    var response =
        await HttpManager.getInstance().dio.get(HttpUrls.projectTree);
    return ProjectTreeEntityEntity.fromJson(jsonDecode(response.toString()))
        .data;
  }

  ///项目列表
  static Future getProjiecList(int pageNum, int cid) async {
    var response = await HttpManager.getInstance().dio.get(
        HttpUrls.projectList + pageNum.toString() + "/json",
        queryParameters: {"cid": cid.toString()});
    return ProjectListEntity.fromJson(jsonDecode(response.toString()))
        .data
        .datas;
  }

  ///公众号tab
  static Future getChapters() async {
    var response = await HttpManager.getInstance().dio.get(HttpUrls.chapters);
    return ProjectTreeEntityEntity.fromJson(jsonDecode(response.toString()))
        .data;
  }

  ///公众号列表
  static Future getChapterList(int pageNum, int id) async {
    var response = await HttpManager.getInstance().dio.get(
        HttpUrls.chaptersList +
            "/" +
            id.toString() +
            "/" +
            pageNum.toString() +
            "/json");
    return ProjectListEntity.fromJson(jsonDecode(response.toString()))
        .data
        .datas;
  }


  ///体系
  static Future getSystemTree() async {
    var response = await HttpManager.getInstance().dio.get(HttpUrls.systemTree);
    return SystemBeanEntity.fromJson(jsonDecode(response.toString()))
        .data;
  }

}
