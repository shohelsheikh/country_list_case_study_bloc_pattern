import 'package:country_list_case_study_bloc_pattern/data/dataproviders/network/api_call.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Fetch Country List Api", () async {
    bool done = false;
    var fetch = (await Api.getCountryList()); // get the country list from api..
    if (fetch != null) {
      done = true;
    }
    expect(done, true);
  });
}
