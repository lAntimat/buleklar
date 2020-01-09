import 'package:buleklar/addproduct/add_product_screen.dart';
import 'package:buleklar/common/busy_overlay.dart';
import 'package:buleklar/common/color_constants.dart';
import 'package:buleklar/gifts_repository.dart';
import 'package:buleklar/home/bloc/bloc.dart';
import 'package:buleklar/home/carousel_widget.dart';
import 'package:buleklar/models/ProductItem.dart';
import 'package:buleklar/user_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeForm extends StatefulWidget {
  final String name;

  HomeForm({Key key, @required this.name}) : super(key: key);

  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(LoadData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.isFabClicked) {
          /*Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Клик по кнопке'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );*/
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return AddProductScreen(userRepository: UserRepository(), giftsRepository: GiftsRepository());
            }),
          );
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return BusyOverlay(
          show: state.isSuccess == false,
          child: SingleChildScrollView(
            child: Container(
              color: AppColors.mainBackground,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  state.carouselItems.length > 0
                      ? CarouselWidget(state.carouselItems).build()
                      : Container(),
                  Container(height: 16.0,),
                  state.categories.length > 0
                      ? getGridList(state.categories)
                      : Container(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget getGridList(List<ProductItem> items) {
    return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: List.generate(items.length, (index) {
          var item = items[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: item.image.large,
                  ),
                ),
                Align(
                  child: Container(
                    width: double.infinity,
                    color: AppColors.mainBackground.withOpacity(0.7),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        item.name,
                        style: TextStyle(color: AppColors.white),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      maxLines: 2,),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                )
              ],
            ),
          );
        }));
  }
}
