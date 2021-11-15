import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'NoInternet.dart';
import 'Shippingform.dart';
import 'Url.dart';
import 'connectivity_provider.dart';
import 'dashboard.dart';
import 'drawer.dart';
import 'instamojo/heloo.dart';


class Listbands {
  String id;
  String brandname;
  String catname;
  String title;
  String proimg;
  String amount;
  String cartid;

  Listbands(
      {this.id,
      this.cartid,
      this.brandname,
      this.catname,
      this.title,
      this.proimg,
      this.amount});
  factory Listbands.fromJson(Map<String, dynamic> json) {
    return Listbands(
        id: json['user_id'],
        catname: json['category_name'],
        title: json['pro_types'],
        proimg: json['cat_img'],
        amount: json['amount'],
        cartid: json['cart_id']);
  }
}

class MyOrder extends StatefulWidget {



  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  String token = "";
  var arrayof = [];
  var totalprice;
  var totalprice1;
  var itemsWithout;
  var cartcount="0";
  String userid, name_pay, mobileno_pay, email_pay, pricefinal_pay,del_user_id;

  String hana, amt;
  Future<List<Listbands>> _carddet;
  void initState() {
    Provider.of<ConnectivityProvider>(context,listen: false).startMonitoring();
   getEmail();
    super.initState();
  }



  Future<List<Listbands>> fetchcarddet() async {

    final http.Response response = await http.post(
      Uri.parse(ApiCall.CartDetails),
      body: {
        'user_id':token,
      },
    );

    var resJson = json.decode(response.body);
    print('object $resJson');
    final items = resJson['cart_details'].cast<Map<String, dynamic>>();
    print('cartdetails $items');
    itemsWithout = resJson['cart_details'];
    // print(itemsWithout.runtimeType);
    print("length of product ${itemsWithout.length}");

    setState(() {
      totalprice = 0;
      for (var d = 0; d < itemsWithout.length; d++) {
        print('val is ${itemsWithout[d]['amount']}');
        totalprice += int.parse(itemsWithout[d]['amount']);
        arrayof.add(itemsWithout[d]['amount']);
      }
      print(arrayof);
      print(arrayof.runtimeType);
      print('sum of values $totalprice');
    });

    return items.map<Listbands>((j) => Listbands.fromJson(j)).toList();
  }
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString('token');
      print("token $token");
      getcartdetail();
    });

  }


  Future getcartdetail()async {
    print("cart 2");
   // var url = 'https://www.binary2quantumsolutions.com/intpro/cart_details.php';
    final http.Response response = await http.post(
      Uri.parse(ApiCall.CartDetails),
      body: {
        'user_id':token,
      },
    );

    var resJson = json.decode(response.body);
    print("cart data");
    print('object $resJson');
    final items = resJson['cart_details'];
    print('cartdetails $items');
    final itemsWithout = resJson['cart_details'];
    var cartcart = resJson['data'];
    print('items product $cartcart');
    setState(() {

      cartcount=cartcart;

    });
    _carddet = fetchcarddet();

    print('item car');

    print('items count $cartcount');



  }
  //payment process
  void buynow() async {
    print(totalprice);
    totalprice1 = totalprice.toString();
    print(totalprice1.runtimeType);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name_pay = (prefs.getString('name1'));
    print('name1 $name_pay');
    userid = (prefs.getString('token'));
    print('userid $userid');
    mobileno_pay = (prefs.getString('mobileno'));
    print('mobileno $mobileno_pay');
    email_pay = (prefs.getString('email'));
    print('email $email_pay');

    print('price $totalprice1');
    //var url = 'https://www.binary2quantumsolutions.com/intpro/pay.php';
    print('url $name_pay');
    print('url $totalprice1');
    print('url $mobileno_pay');
    print('url $email_pay');
    print('url $userid');

    http.post(
        Uri.parse(ApiCall.PaymentProcessPay),
        body: {
      'userName': name_pay,
      'payAmount': totalprice1,
      'userMobile': mobileno_pay,
      'userEmail': email_pay,
      'userId': userid,
      'purpose': 'plywood'
    }).then((res) {
      var resJson = json.decode(res.body);
      print('resj $resJson');
      var paymentprocess = resJson['payment_request']['longurl'];
      print('resjosn $paymentprocess');
      var redirecturlinsta = resJson['payment_request']['redirect_url'];
      print('redirecturlinsta $redirecturlinsta');

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => Nextsteps(
                    paymenturl: paymentprocess,
                    redirect: redirecturlinsta,
                  )),(route)=>false);


    });
  }
  //end paymentprocess

  void delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    del_user_id=(prefs.getString('token'));
    print('delete user id $del_user_id');

    print('del ${ApiCall.DeleteCart}');
    print('cartid $hana');
    final http.Response response =
        await http.post(
            Uri.parse(ApiCall.DeleteCart),
            body: {
              'cart_id': hana,
              'user_id':del_user_id
            });
    var resJson = json.decode(response.body);
    print('delete process $resJson');
    String count_changedd= resJson["data"];
    print('delete count changed $count_changedd');

    Fluttertoast.showToast(
        msg: "Deleted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0);
setState(() {
  cartcount="";
  cartcount=count_changedd;
});
    fetchcarddet();
  }

  @override
  Widget build(BuildContext context) {

    return   Consumer<ConnectivityProvider>(
      builder: (context,model,child){
        if(model.isOnline!=null){
          return model.isOnline?
          WillPopScope(
              onWillPop: (){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Homee(),
                  ),(route) => false
                );
              },

              child:  Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  elevation: 0.0,
                  title: Text('Products',
                      style: TextStyle(
                          fontFamily: 'Montserrat', fontSize: 22.0, color: Colors.white)),
                  actions: [
                    Stack(
                      children: <Widget>[
                        new IconButton(
                          icon: new Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => MyOrder()
                                ),(route)=> false
                            );
                            print('cartcount $cartcount');
                          },
                        ),
                        cartcount == 0
                            ? new Container()
                            : new Positioned(
                            child: new Stack(
                              children: <Widget>[
                                new Icon(Icons.brightness_1,
                                    size: 25.0, color: Colors.red[800]),
                                new Positioned(
                                    top: 3.0,
                                    right: 5.0,
                                    child: new Center(
                                      child: Text(
                                        cartcount.toString(),
                                        style: new TextStyle(
                                            color: Colors.white,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )),
                              ],
                            )),
                      ],
                    ),
                  ],
                  centerTitle: true,
                ),
                drawer: Drawer_main(),
                bottomSheet:
                // Padding(
                //   padding: EdgeInsets.only(left: 10, right: 10),
                //   child:
                Row(
                  children: <Widget>[
                    Expanded(
                        child: RaisedButton(
                          onPressed: () {
                            print('enter the button');
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => MyOrder()));
                          },
                          child: Text("Total : $totalprice"),
                          color: Theme.of(context).colorScheme.primary,
                          textColor: Colors.white,
                        )),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: RaisedButton(
                          onPressed: (){
                            print(totalprice);
                            if(totalprice==0){
                              Fluttertoast.showToast(
                                  msg: 'Your Cart is empty ',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIos: 1,
                                  fontSize: 16.0);

                            }else{
                              checkoutprocessvalidate();
                            }
                          },
                          child: Text("Checkout"),
                          color: Theme.of(context).colorScheme.primary,
                          textColor: Colors.white,
                        )),
                  ],
                ),

                body: SafeArea(
                  child:totalprice==0?
                  Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top:20),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/addtocart.png"),
                                colorFilter: ColorFilter.mode(
                                    Colors.white.withOpacity(0.8), BlendMode.dstATop),

                              )),
                          height: MediaQuery
                              .of(context)
                              .size
                              .height/2,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Text("Your Cart is Empty",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 22),),
                        ),
                      ],
                    ),
                  )
                      :Container(
                    child: FutureBuilder<List<Listbands>>(
                        future: _carddet,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: CircularProgressIndicator());
                          return Container(
                              child: ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    var item = snapshot.data[index];
                                    amt = item.amount;
                                    print('amt $amt');
                                    return Card(
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              ListTile(
                                                //isThreeLine: true,
                                                title: Text(item.catname),
                                                leading: Container(
                                                  height: 75,
                                                  width: 75,
                                                  child: Image.network(
                                                      '${snapshot.data[index].proimg}'),
                                                ),
                                                trailing: GestureDetector(
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                    ),
                                                    onTap: () {
                                                      print('amt $amt');
                                                      amt = item.amount;

                                                      hana = item.cartid;
                                                      print(snapshot.data[index].cartid);
                                                      setState(() {
                                                        snapshot.data.remove(item);

                                                        delete();
                                                      });

                                                      _carddet;
                                                    }),
                                                subtitle: Text(
                                                    'Particulars :  ${snapshot.data[index].title} \n Order Id :  ${snapshot.data[index].id}\n price : ${item.amount}'),
                                              ),
                                            ]));
                                  }));
                        }),
                  ),
                ),
              ))
              :NoInternet();
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

   checkoutprocessvalidate() {

       print("checkout $totalprice");
       if (totalprice <= 10000) {
         Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(
                 builder: (context) => ShippingForm(
                     ship_mode:"cart",
                     total_price:totalprice
                 )),(route)=>false);
         // buynow();
       } else
         {
         print('select the more amount');
         Fluttertoast.showToast(
             msg: 'Your Maximum Limit 10000',
             toastLength: Toast.LENGTH_SHORT,
             gravity: ToastGravity.TOP,
             timeInSecForIos: 1,
             fontSize: 16.0);
       }

   }
}
