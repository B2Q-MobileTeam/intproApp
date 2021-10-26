import 'dart:convert';

import 'package:flat_icons_flutter/flat_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'instamojo/nextstep.dart';
class ShippingForm extends StatefulWidget {
  String ship_brandid,ship_productid,ship_price_id,ship_quantity,
      ship_amt,shippurpose,ship_mode;

  ShippingForm({this.ship_brandid, this.ship_productid, this. ship_price_id,this.ship_quantity,
    this.ship_amt, this.shippurpose,this.ship_mode});

  @override
  _ShippingFormState createState() => _ShippingFormState();
}

class _ShippingFormState extends State<ShippingForm> {
  bool _validate = false;
  String brand_no,ship_name,ship_mobileno,ship_email,ship_address,ship_pincode,ship_userid;
  String user_id_shipping = "";
  String ship_status;
  bool _isvisible=true;
  bool shipping_status;
  String shipmodestatus= "old";
  String sh_username="";
  String sh_email="";
  String sh_address="";
  String sh_pincode="";
  String sh_mob="";
  String userid, name_pay, mobileno_pay, email_pay, pricefinal_pay;
  String pay_shippingstatus;

  TextEditingController shipname = new TextEditingController();
  TextEditingController shipemail = new TextEditingController();
  TextEditingController shipaddress = new TextEditingController();
  TextEditingController shippincode = new TextEditingController();
  TextEditingController shipmobno = new TextEditingController();
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      user_id_shipping = preferences.getString('token');
      print("idid $user_id_shipping");
      getshippingstatus();
    });
  }


  void shippingformsubmit()async {
    String pay_checkmode=widget.ship_mode;
    print('paycheckmode $pay_checkmode');


    SharedPreferences prefs = await SharedPreferences.getInstance();
    name_pay = (prefs.getString('name1'));
    print('name1 $name_pay');
    mobileno_pay = (prefs.getString('mobileno'));
    print('mobileno $mobileno_pay');
    email_pay = (prefs.getString('email'));
    print('email $email_pay');
    //print('price $totalprice');

    print('url $name_pay');
    String pay_brandid = widget.ship_brandid;
    String pay_proid=widget.ship_productid;
    String pay_priceid=widget.ship_price_id;
    String pay_quantity=widget.ship_quantity;
    print('$pay_brandid,$pay_proid,$pay_priceid,$pay_quantity');
    String pay_amount=widget.ship_amt;
    String pay_purposetitle=widget.shippurpose;

    print('$pay_amount,$pay_purposetitle,$pay_checkmode');
    sh_username = shipname.text;
    sh_email = shipemail.text;
    sh_address = shipaddress.text;
    sh_pincode = shippincode.text;
    sh_mob = shipmobno.text;
    pay_shippingstatus = shipmodestatus;
    print('$sh_username,$sh_email,$sh_address,$sh_pincode,$sh_mob,$pay_shippingstatus');


    var urls = 'https://www.binary2quantumsolutions.com/intpro/pay.php';
    print('url $urls');
    if(pay_checkmode=="cart"){
      http.post(
          Uri.parse(urls),
          body: {
            "checkoutmode": pay_checkmode,
            "name": sh_username,
            "email":sh_email,
            "mobileno": sh_mob,
            "address": sh_address,
            "pincode": sh_pincode,
            "shippingstatus": pay_shippingstatus,
            "mode": "Mobile",
            "userid":user_id_shipping,
            "userMobile":mobileno_pay,
            "userName":name_pay,
            "userEmail":email_pay
          }).then((res) {
        var resJsonship = json.decode(res.body);
        var statusprocess = resJsonship['success'];
        print('resjosn status $statusprocess');
        print('resj full response $resJsonship');
        var paymentprocess = resJsonship['payment_request']['longurl'];
        print('resjosn $paymentprocess');
        var redirecturlinsta = resJsonship['payment_request']['redirect_url'];
        print('redirecturlinsta $redirecturlinsta');

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Nextstep(
                  paymenturl: paymentprocess,
                  redirect: redirecturlinsta,
                )));

      });
    }else{
    http.post(
        Uri.parse(urls),
        body: {
          "brand_id": pay_brandid,
          "pro_id": pay_proid,
          "price_id": pay_priceid,
          "quantity": pay_quantity,
          "payAmount": pay_amount,
          "purpose": pay_purposetitle,
          "checkoutmode": pay_checkmode,
          "name": sh_username,
          "email":sh_email,
          "mobileno": sh_mob,
          "address": sh_address,
          "pincode": sh_pincode,
          "shippingstatus": pay_shippingstatus,
          "mode": "Mobile",
          "userid":user_id_shipping,
          "userMobile":mobileno_pay,
          "userName":name_pay,
          "userEmail":email_pay
        }).then((res) {
      var resJsonship = json.decode(res.body);
      var statusprocess = resJsonship['success'];
      print('resjosn status $statusprocess');
      print('resj full response $resJsonship');
      var paymentprocess = resJsonship['payment_request']['longurl'];
      print('resjosn $paymentprocess');
      var redirecturlinsta = resJsonship['payment_request']['redirect_url'];
      print('redirecturlinsta $redirecturlinsta');

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Nextstep(
                paymenturl: paymentprocess,
                redirect: redirecturlinsta,
              )));

    });}
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
      bottomSheet: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
          ),
          onPressed: (){
            setState(() {
              validateshipping();
            });

            print('values ${shipname.text} ${shipemail.text} ${shipaddress.text} ${shippincode.text} ${shipmobno.text}');
          },
          child: Text("Proceed to pay"),
        ),
      ),
      appBar: AppBar(
        title: Text("Shipping Details"),
      ),
      body: SingleChildScrollView(
        child: Container(
            child:_isvisible?Center(
              child: CircularProgressIndicator(),
            ):Container(
                child:shipping_status?OldShippingAddress():NewShippingAddress()
            )
        ),
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
                      onPressed: (){
                     setState(() {
                       shipmodestatus= "new";
                       shipping_status=false;

                       NewShippingAddress();
                     });
                      },
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
    bool _validate = false;
    return Container(
      padding: EdgeInsets.only(top: 10,bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
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
              child: Form(
                child: Padding(
                  padding: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: shipname,


                        decoration: new InputDecoration(

                          icon:Icon(Icons.person,color: Colors.blueGrey,),
                          labelText: "Name",
                          errorText: _validate ? 'Name Can\'t Be Empty' : null,
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10,),
                      TextField (
                        controller: shipemail,
                        decoration: new InputDecoration(
                          labelText: "Email Id",
                          errorText: _validate ? 'Email Id Can\'t Be Empty' : null,

                          icon:Icon(Icons.mail,color: Colors.blueGrey,),

                        ),

                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        controller: shipaddress,

                        maxLines: 5,minLines: 1,
                        decoration: new InputDecoration(

                          icon:Icon(Icons.location_city,color: Colors.blueGrey,),
                          labelText: "Address",
                          errorText: _validate ? 'Address Can\'t Be Empty' : null,
                        ),
                        keyboardType: TextInputType.multiline,

                      ),
                      SizedBox(height: 10,),
                      TextField(
                        controller: shippincode,
                        decoration: new InputDecoration(
                          icon:Icon(Icons.add_location,color: Colors.blueGrey,),
                          labelText: "Pincode",
                          errorText: _validate ? 'Pincode Can\'t Be Empty' : null,

                        ),
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10,),
                      TextField(
                     controller: shipmobno,
                        decoration: new InputDecoration(

                          icon:Icon(Icons.phone_android_sharp,color: Colors.blueGrey,),
                          labelText: "Mobile No.",
                          errorText: _validate ? 'Mobile No. Can\'t Be Empty' : null,

                        ),
                        keyboardType: TextInputType.number,
                      )


                    ],
                  ),
                ),
              )
          )
        ],

      ),
    );
  }

  void validateshipping() {
    print("pay_shippingfdsdfgstatus $shipmodestatus");
if(shipmodestatus=="old"){
  shippingformsubmit();
}else{
  if((shipname.text.isEmpty)||(shipemail.text.isEmpty)||(shipaddress.text.isEmpty)||(shippincode.text.isEmpty)||(shipmobno.text.isEmpty)){
    Fluttertoast.showToast(
        msg: "Please fill all the fields",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        fontSize: 16.0);
  }else{
    shippingformsubmit();
  }
}

  }


}

