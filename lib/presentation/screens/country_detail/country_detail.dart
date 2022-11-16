import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

 import '../../../business_logic/bloc/country_list_bloc/country_list_bloc.dart';
import '../../../locales/locale_constant.dart';
import '../../../utils/asset_helper.dart';
import '../../../widgets/all_text_view.dart';

class CountryDetailPage extends StatelessWidget {
  int itemIndex;

  CountryDetailPage({Key? key, required this.itemIndex}) : super(key: key);

  final NumberFormat areaFormat =
  NumberFormat('###,###,###,###.#', 'en_US'); // for format the area.

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return

      BlocBuilder<CountrylistBloc, CountrylistState>(
        builder: (context, state) {
          CountrylistBloc bloc = BlocProvider.of<CountrylistBloc>( context);  // get bloc data.
          return    Scaffold(
            appBar: appBarWidget(context,bloc),
            body: SingleChildScrollView(
              child: countryDetails(bloc), // created separate function for country detail
            ),
          );
        },
      );





  }

  // App Bar
  appBarWidget(BuildContext context, CountrylistBloc bloc) {
    return AppBar(
      backgroundColor: Theme
          .of(context)
          .scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),

      Expanded(
        child: Text(
          bloc.countryListNew![itemIndex].name
              ?.common ??
              "NA",
          style: TextStyle(
              fontSize: 13.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),


          SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }

  // country detail
  Widget countryDetails( CountrylistBloc bloc) {
    return
      Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CachedNetworkImage(
              imageUrl: bloc
                  .countryListNew![
              itemIndex]
                  .flags
                  ?.png ??
                  "",
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
              new Image.asset(AssetHelper.noimage, height: 20.h),
            ),
            marginTop(),
            AllCommonTextView(
              StringsConstant.officialName,
              bloc
                  .countryListNew![
              itemIndex]
                  .name
                  ?.official ??
                  "NA",
              Icon(
                Icons.home,
              ),
            ),
            marginTop(),
            AllCommonTextView(
              StringsConstant.capital,
              bloc
                  .countryListNew![
              itemIndex]
                  .capital ??
                  "NA",
              Icon(
                Icons.flag,
              ),
            ),
            marginTop(),
            AllCommonTextView(
              StringsConstant.continent,
              bloc
                  .countryListNew![
              itemIndex]
                  .continents ??
                  "NA",
              Icon(
                Icons.flag,
              ),
            ),
            marginTop(),
            AllCommonTextView(
              StringsConstant.population,
              bloc
                  .countryListNew![
              itemIndex]
                  .population
                  .toString() ??
                  "NA",
              Icon(
                Icons.people,
              ),
            ),
            marginTop(),
            AllCommonTextView(
              StringsConstant.region,
              bloc
                  .countryListNew![
              itemIndex]
                  .region ??
                  "NA",
              Icon(
                Icons.people,
              ),
            ),
            marginTop(),
            AllCommonTextView(
              StringsConstant.subRegion,
              bloc
                  .countryListNew![
              itemIndex]
                  .subregion ??
                  "NA",
              Icon(
                Icons.people,
              ),
            ),
            marginTop(),
            AllCommonTextView(
              StringsConstant.area,
              '${areaFormat.format(
                  bloc.countryListNew![itemIndex].area ?? "")} km\u{00B2}',
              Icon(
                Icons.area_chart,
              ),
            )
          ]);
  }

  // margin top
  Widget marginTop() {
    return Container(
      margin: EdgeInsets.only(top: 2.h),
    );
  }
}
