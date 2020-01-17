import 'package:buleklar/common/busy_overlay.dart';
import 'package:buleklar/models/ProductItem.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

class ProductDetailForm extends StatefulWidget {
  final String _id;

  ProductDetailForm({Key key, @required String id})
      : assert(id != null),
        _id = id,
        super(key: key);

  State<ProductDetailForm> createState() => _ProductDetailFormState();
}

class _ProductDetailFormState extends State<ProductDetailForm> {
  ProductDetailBloc _productDetailBloc;

  @override
  void initState() {
    super.initState();
    _productDetailBloc = BlocProvider.of<ProductDetailBloc>(context);
    _productDetailBloc.add(LoadData(widget._id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductDetailBloc, ProductDetailState>(
      listener: (context, state) {},
      child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          return BusyOverlay(
              show: state.isLoading,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: !state.isLoading ? getPageView(state.productItem.images): Container(),
              ));
        },
      ),
    );
  }

  Widget getPageView(List<Images> images) {
    return Container(
      child: PageView.builder(
        itemBuilder: (context, position) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(height: 10, width: 10, child: CircularProgressIndicator()),
                    imageUrl:
                    images[position].medium ?? "",
                    height: 200)),
          );
        },
        itemCount: images.length, // Can be null
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
