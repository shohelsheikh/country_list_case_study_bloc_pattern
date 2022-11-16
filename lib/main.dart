import 'package:country_list_case_study_bloc_pattern/business_logic/bloc/country_list_bloc/country_list_bloc.dart';
import 'package:country_list_case_study_bloc_pattern/presentation/screens/country_list/country_list_page.dart';
import 'package:country_list_case_study_bloc_pattern/presentation/screens/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:country_list_case_study_bloc_pattern/utils/color_constant.dart';
import 'package:sizer/sizer.dart';

import 'data/localdb/hive_db_manager.dart';
import 'locales/locale_constant.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveDBManager.instance.onInitLocalDb(); // initialize the hive db
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sizer is for responsive design
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: StringsConstant.appName,
        theme: ThemeData(
          backgroundColor: Colors.white,
          primaryColor: ColorConstant.colorApp,
        ),
        home: BlocProvider(
          create: (context) => CountrylistBloc(),  // country bloc used in app.
          child: SplashPage(),  // jump to splash screen
        ),
      );
    });
  }

}


