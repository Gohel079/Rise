import 'package:http/http.dart' as http;

const String merchantId = "246085";
const String accessCode = "AVEM03HA05CL13MELC";
const String urlRSAKey = "https://hcserve.com/Token_MobileApp/GetRSA.aspx";
const String urlRedirect = "https://hcserve.com/Token_MobileApp/ccavResponseHandler.aspx";
const String urlCancel = "https://hcserve.com/Token_MobileApp/ccavResponseHandler.aspx";
const String urlTransactionCCAvenue = "https://test.ccavenue.com/transaction/initTrans";

Future<void> getEncryptValRSA(String accessCode,String orderId, Function(String) onResponse, Function(String?) onError) async {
  var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  var request = http.Request('POST', Uri.parse(urlRSAKey));
  request.bodyFields = {'order_id': orderId, 'access_code' : accessCode};
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    final httpResponse = await response.stream.bytesToString();
    print(httpResponse);
    onResponse.call(httpResponse);
  } else {
    onError.call(response.reasonPhrase);
  }
}