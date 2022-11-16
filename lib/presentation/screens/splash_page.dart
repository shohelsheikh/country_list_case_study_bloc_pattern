import 'dart:async';

import 'package:country_list_case_study_bloc_pattern/presentation/screens/country_list/country_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../business_logic/bloc/country_list_bloc/country_list_bloc.dart';
import '../../locales/locale_constant.dart';
import '../../widgets/button/app_button.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AppButton {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text(
                StringsConstant.caseStudy,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                StringsConstant.countryListApp,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                StringsConstant.importantNotes,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsConstant.one,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        StringsConstant.instruction1,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsConstant.two,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        StringsConstant.instruction2,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsConstant.three,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        StringsConstant.instruction3,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              BlocBuilder<CountrylistBloc, CountrylistState>(
                  builder: (context, state) {
                CountrylistBloc bloc =
                    BlocProvider.of<CountrylistBloc>(context);
                return elevatedButton(
                    title: StringsConstant.getStarted,
                    onPressed: () {
                      // jump to country list page and with default state.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                            value: bloc,
                            child: CountryListPage(),
                          ),
                        ),
                      );
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
