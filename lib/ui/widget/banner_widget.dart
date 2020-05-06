import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wanflutter/model/home_model.dart';
import 'package:wanflutter/provider/view_state_model.dart';

class BannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120 + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child:Consumer<HomeModel>(builder: (_, homeModel, __){
        if (homeModel.viewState == ViewState.busy) {
          return CupertinoActivityIndicator();
        } else {
          if (homeModel.banners.length <= 0) {
            return Image.network(
              "https://www.wanandroid.com/blogimgs/4f70771f-2d7a-4494-b9fd-0d11eca0bd6e.png",
              fit: BoxFit.cover,
            );
          } else {
            return Swiper(
              loop: true,
              autoplay: true,
              autoplayDelay: 3000,
              //指示器
              pagination: SwiperPagination(
                builder: SwiperPagination.dots,
                alignment: Alignment.bottomRight,
              ),
              itemCount: homeModel.banners.length,
              itemBuilder: (ctx, index) {
                return InkWell(
                  onTap: () {
                    Fluttertoast.showToast(msg:"第"+ (index+1).toString()+"条");
                  },
                  child: CachedNetworkImage(
                    imageUrl: homeModel.banners[index].imagePath,
                    placeholder: (context, url) {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Icon(Icons.error);
                    },
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }
        }
      }),);
//      Container(child: bannerContent(homeModel)),
//    );
  }

}
