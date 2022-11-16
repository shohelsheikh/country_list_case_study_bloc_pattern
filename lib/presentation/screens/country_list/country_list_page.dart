import 'package:country_list_case_study_bloc_pattern/presentation/screens/country_detail/country_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import 'package:cached_network_image/cached_network_image.dart';
import '../../../business_logic/bloc/country_list_bloc/country_list_bloc.dart';
import '../../../data/model/country_list_response.dart';
import '../../../locales/locale_constant.dart';
import '../../../utils/asset_helper.dart';
import '../../../utils/color_constant.dart';

class CountryListPage extends StatelessWidget {
  CountryListPage({Key? key}) : super(key: key);

  List<CountryListResponse>? countryList = []; // to show braking list

  @override
  Widget build(BuildContext context) {
    // get the country list
    BlocProvider.of<CountrylistBloc>(context).add(
      GetCountryList(),
    );
    return Scaffold(
      appBar: appBarWidget(context),
      body: BlocBuilder<CountrylistBloc, CountrylistState>(
        builder: (context, state) {
          CountrylistBloc bloc = BlocProvider.of<CountrylistBloc>(context);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // searchbar
              searchBar(context),
              // list view for country list
              listView(context,bloc)
            ],
          );
        },
      ),
    );
  }

  // App Bar
  appBarWidget(BuildContext context) {
    return AppBar(
      backgroundColor: ColorConstant.colorWhite,
      automaticallyImplyLeading: false,
      centerTitle: true,
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
          Text(
            '# '+ StringsConstant.appName,
            style: TextStyle(
                fontSize: 15.sp,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }

  // Search Bar
  Widget searchBar(BuildContext context) {
    return Container(
        margin:
            EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0, bottom: 10.0),
        height: 5.h,
        child: TextFormField(
          onChanged: (value) {
            BlocProvider.of<CountrylistBloc>(context).add(
              GetCountrySearch(searchText: value),
            );
          },
          readOnly: false,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorConstant.searcbBarcolor, width: 2.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorConstant.searcbBarcolor, width: 2.0),
            ),
            border:
                UnderlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
            hintText: StringsConstant.searchCountry,
          ),
        ));
  }

  // Listview
  Widget listView(BuildContext context,CountrylistBloc bloc) {
    return Expanded(
      flex: 1,
      child: BlocBuilder<CountrylistBloc, CountrylistState>(
        builder: (context, state) {
          if (state is CountrylistLoaded) {
            countryList = state.brakingList;
            return ListView.builder(
              itemBuilder: (context, index) {
                return countryListItem(
                    context, index, bloc); // sepearte list item
              },
              itemCount: countryList?.length,
            );
          }
          if (state is CountrylistLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CountrylistFailed) {
            return Center(
              child: Text(
                'Failed to load list',
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  // Country Listitem
  Widget countryListItem(
      BuildContext context, int index,CountrylistBloc bloc) {
    String? name = countryList![index].name?.common;
    String? capital = countryList![index].capital;
    String? image = countryList![index].flags?.png;
    return InkWell(
      onTap: () {

        // navigate to detail page and pass the bloc.

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: bloc,
              child: CountryDetailPage(itemIndex: index),
            ),
          ),
        );

        },
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: CachedNetworkImage(
                imageUrl: image ?? "",
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    new Image.asset(AssetHelper.noimage),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name ?? "",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    capital ?? "",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: SizedBox(
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
