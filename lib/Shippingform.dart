import 'dart:convert';

import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class ShippingForm extends StatefulWidget {
  @override
  _ShippingFormState createState() => _ShippingFormState();
}

class _ShippingFormState extends State<ShippingForm> {
  String brand_no,ship_name,ship_mobileno,ship_email,ship_address,ship_pincode,ship_userid;
  String user_id_shipping = "";
  String ship_status;
  bool _isvisible=true;
  bool shipping_status;


  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id_shipping = preferences.getString('token');
      print("idid $user_id_shipping");
      getshippingstatus();
    });
  }

  void getshippingstatus() {


    var shippingstatus = "https://www.binary2quantumsolutions.com/intpro/shipping.php";
    print('url $shippingstatus');

    http.post(
        Uri.parse(shippingstatus),
        body: {
        "userid":"80"
        }).then((res) {
      var resJson =jsonDecode(res.body);
      print('resjosn shipping  $resJson["brand_list]');
      ship_status=resJson["status"];
      print("status $ship_status");
      var brand_list_details=resJson["brand_list"];
      print(brand_list_details[0]["no"]);
      brand_no=brand_list_details[0]["no"];
      ship_name=brand_list_details[0]["name"];
      ship_mobileno=brand_list_details[0]["mobileno"];
      ship_email=brand_list_details[0]["email"];
      ship_address=brand_list_details[0]["address"];
      ship_pincode=brand_list_details[0]["pincode"];
      ship_userid=brand_list_details[0]["userid"];
      print("values  $brand_no $ship_name $ship_mobileno $ship_email $ship_address $ship_pincode $ship_userid");

setState(() {

  _isvisible=false;
  if(ship_status=="true"){
    shipping_status=true;
  }else{
    shipping_status=false;
  }
});


    });
  }

  @override
  void initState() {
    getEmail();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shipping Details"),
      ),
      body: Container(
child:_isvisible?Center(
  child: CircularProgressIndicator(),
):Container(
  child:shipping_status?OldShippingAddress():NewShippingAddress()
)
      ),
    );
  }
  Widget OldShippingAddress(){
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Padding(
          padding: EdgeInsets.all(10),
          child:   Text("Shippng Address",style: TextStyle(color: Colors.black87,
              fontWeight: FontWeight.w800,fontSize: 16),textAlign: TextAlign.start,),
        ),
          Container(
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.blueGrey, spreadRadius:3),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$ship_name",style: TextStyle(color: Colors.black87,
                      fontWeight: FontWeight.w500,fontSize: 16),),
                  Text("$ship_email",style: TextStyle(color: Colors.black54,
                      fontWeight: FontWeight.w500,fontSize: 16),),
                  Text("$ship_address",style: TextStyle(color: Colors.black54,
                      fontWeight: FontWeight.w500,fontSize: 16),),
                  Text("$ship_pincode",style: TextStyle(color: Colors.black54,
                      fontWeight: FontWeight.w500,fontSize: 16),),
                  Text(" Mobile No.$ship_mobileno",style: TextStyle(color: Colors.black54,
                      fontWeight: FontWeight.w500,fontSize: 16),),

                  Align(
                    alignment: Alignment.topRight,
                    child: OutlinedButton.icon(
                      label: Text("change"),
                      onPressed: (){},
                      icon: Icon(Icons.edit,size: 15,),
                    ),)
                ],
              ),
            )
          )
        ],

      ),
    );
  }

  Widget NewShippingAddress(){
    return Container(
      child: Text("New"),
    );
  }
}

