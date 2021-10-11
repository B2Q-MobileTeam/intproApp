import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intpro_final/Dashboardfragment.dart';
import 'package:intpro_final/instamojo/payprocess.dart';
import 'package:intpro_final/model/AddTocartWidget.dart';
import 'package:intpro_final/model/Cartcount.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'instamojo/nextstep.dart';
import 'order_detail.dart';

class Add {
  String id;
  String brandname;
  String image, price;
  Add({this.id, this.brandname, this.image, this.price});
  factory Add.fromJson(Map<String, dynamic> json) {
    return Add(id: json['id'], price: json['price']);
  }
}

class Cart extends StatefulWidget {

  final String carttid, cartid, title;
  Cart({Key key, this.carttid, this.cartid, this.title,}) : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  final StringCallback callback;
  _CartState({this.callback});
  List<Add> _cartList = List<Add>();
  int counter = 0;
  int _count = 1;
  String userid, name_pay, mobileno_pay, email_pay, pricefinal_pay;
  int count_increase;
  int count_decrease;
  String totalprice = '0';
  String cartcountsss;

  List datapro = List();
  List typepro = List();
  String selectedvalue, typevalue;
  var pro_id, a;
  String count_changed;

  var price = '';
  var amount, b;
  String img;

  //thickness api

  Future<String> fetchcart() async {
    var cart = widget.carttid;
    print(' cart $cart');
    var url =
        'https://www.binary2quantumsolutions.com/intpro/product_measures.php';

    print('url $url');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final http.Response response = await http.post(
      Uri.parse(url),
      body: {'brand_id': widget.carttid},
    );
    var resJson = json.decode(response.body);
    // print('object $resJson');
    var product = resJson['product_measure'];
    img = product[0]['cat_img'];
    print('img $img');

    // print('product $product');
    setState(() {
      userid = (prefs.getString('token'));
      print('share $userid');
      datapro = product;
    });
    // print('object $datapro');
  }
  //end thicknes api

  //type api

  Future<String> fetchtype() async {
    var cart = widget.carttid;
    print(' cart $cart');

    var url =
        'https://www.binary2quantumsolutions.com/intpro/product_types.php';
    print('type $url');

    final http.Response response = await http.post(
      Uri.parse(url),
      body: {'m_id': selectedvalue},
    );
    var resJson = json.decode(response.body);
    // print('type $resJson');
    var types = resJson['product_types'];

    // print('type $types');
    setState(() {
      typepro = types;
    });
    // print('producttype $typepro');
  }
  //end type api

  //price api
  Future<String> fetchprice() async {
    var cart = widget.carttid;
    print(' cart $cart');

    var url =
        'https://www.binary2quantumsolutions.com/intpro/product_price.php';
    print('price $url');

    final http.Response response = await http.post(
      Uri.parse(url),
      body: {
        'm_id': selectedvalue,
        'brand_id': widget.carttid,
        'type_id': typevalue
      },
    );
    var resJson = json.decode(response.body);
    print('price $resJson');
    var types = resJson['product_price'];
    print('price $types');

    price = types[0]['price'];
    pro_id = types[0]['price_id'];

    print('prices $price');
    print('pro_id $pro_id');

    setState(() {
      amount = price;
      print('amout is $amount');
      calculationpart();
      //fetchprice();
    });
  }

  //end price api

  //payment instamojo process

  void buynow() async {
    print(totalprice);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name_pay = (prefs.getString('name1'));
    print('name1 $name_pay');
    mobileno_pay = (prefs.getString('mobileno'));
    print('mobileno $mobileno_pay');
    email_pay = (prefs.getString('email'));
    print('email $email_pay');
    print('price $totalprice');
    var url = 'https://www.binary2quantumsolutions.com/intpro/pay.php';
    print('url $name_pay');

    http.post(
        Uri.parse(url),
        body: {
      'userName': name_pay,
      'payAmount': totalprice,
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

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Nextstep(
                    paymenturl: paymentprocess,
                    redirect: redirecturlinsta,
                  )));

      //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Hello()));
    });
  }
  //end payment instamojo
  void numbercount()async {

    print('count_changed $count_changed');
    SharedPreferences Preferences = await SharedPreferences.getInstance();
     String  cartcounts = (Preferences.getString('cartcount'));
      print('count get $cartcounts');
      Preferences.remove("cartcount");
    String  cartcountss = (Preferences.getString('cartcount'));
      print('count remove $cartcountss');
      Preferences.setString("cartcount", count_changed);
    cartcountsss= (Preferences.getString('cartcount'));
      print('cart count final $cartcountsss');

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => MyOrder()));
    //  AddToCartWidget(cartcounts: cartcountsss);




  }



  //cart api
  Future<String> fetchpro() async {
    var url = 'https://www.binary2quantumsolutions.com/intpro/add_cart.php';
    print('cart price $url');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = (prefs.getString('token'));
      print('userid $userid');
    });

    final http.Response response = await http.post(
      Uri.parse(url),
      body: {
        'price_id': pro_id,
        'amount': totalprice,
        'quantity': _count.toString(),
        'user_id': userid
      },
    );
    var resJson = json.decode(response.body);
    print('add to cart $resJson');
    String count_changedd= resJson["data"];
    count_changed=count_changedd;
    DashboardFragment.of(context).checkprocess(count_changed);

    print('count changed $count_changed');
    //int count_changed = count_changedd;

    Fluttertoast.showToast(
        msg: "Added to Cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0);
  }

  //endn cart api

  @override
  void initState() {
    fetchcart();


    super.initState();
  }

  calculationpart() {
    print('val is (($amount)*($_count))');
    var pri = amount;
    var qty = _count;
    var c = int.parse(pri) * qty;
    totalprice = c.toString();
    print('value is $c');
  }

  decre() {
    setState(() {
      _count--;
      print("count value is $_count");
      calculationpart();
    });
  }

  incre() {
    setState(() {
      _count++;
      print("count value is $_count");
      calculationpart();
    });
  }

  Widget build(BuildContext context) {

    return

      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text('Add to Cart',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 22.0,
                  color: Colors.black)),
          centerTitle: true,
        ),
        bottomSheet: Row(
          children: <Widget>[
            Expanded(
             child:
                  RaisedButton(
                    child: Text('Add to Cart'),
                    onPressed: (){
                      // myModel.doaddproduct();
                    //  DashboardFragment.of(context).cartcount="34";


                      fetchpro();
                     // checkprocess("23");
                    },
                  ),

//                 child: RaisedButton
//                   (
//                   onPressed: (){
// CartModel.
//                   },
//             //   onPressed: () {
//             //     cartcount.addToCartUrl(),
//             //     // fetchpro();
//             //
//             // //     var b = int.parse(totalprice);
//             // //
//             // //     if (b <= 10000) {
//             // //       fetchpro();
//             // //
//             // //       setState(() {
//             // //         counter++;
//             // //       });
//             // //     }
//             // //     else {
//             // //       print('data increased lot');
//             // //       Fluttertoast.showToast(
//             // // msg: "Your Maximum Limit is 10000",
//             // // toastLength: Toast.LENGTH_SHORT,
//             // // gravity: ToastGravity.TOP,
//             // // timeInSecForIos: 1,
//             // // fontSize: 16.0);
//             // //     }
//             //
//             //     //print('enter the button');
//             //     // Navigator.push(
//             //     //     context,
//             //     //     MaterialPageRoute(
//             //     //         builder: (context) => MyOrder()));
//             //   },
//               child: Text("Add to Cart"),
//               color: Theme.of(context).colorScheme.primary,
//               textColor: Colors.white,
//             )
            ),
            Expanded(
                child: RaisedButton(
              onPressed: () {
               buynow();
              },
              child: Text("Buy Now"),
              color: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
            )
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    img == null
                        ? Center(child: CircularProgressIndicator())
                        : Center(child: Image.network(img)),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, top: 30.0, bottom: 20.0),
                      child: Text(widget.title,
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: DropdownButton(
                                value: selectedvalue,
                                items: datapro.map((data) {
                                  return DropdownMenuItem(
                                      value: data['m_id'].toString(),
                                      child: Text(data['pro_types']));
                                }).toList(),
                                hint: Text('Select  thickness'),
                                onChanged: (value) {
                                  setState(() {
                                    selectedvalue = value;
                                    typevalue = null;
                                    totalprice = '0';
                                    _count = 1;
                                    fetchtype();
                                    print('selected $selectedvalue');
                                  });
                                }),
                          ),
                          Container(
                            child: DropdownButton(
                                value: typevalue,
                                items: typepro.map((item) {
                                  return DropdownMenuItem(
                                      value: item['type_id'],
                                      child: Text(item['type']));
                                }).toList(),
                                hint: Text('Select  type'),
                                onChanged: (value) {
                                  setState(() {
                                    typevalue = value;

                                    fetchprice();
                                  });

                                  print('typeid $typevalue');
                                }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 30.0, top: 10.0, right: 20.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Price : $totalprice',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 20.0,
                                    color: Colors.grey)),
                            Container(
                                height: 25.0, color: Colors.grey, width: 1.0),
                            Container(
                                width: 125.0,
                                height: 40.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17.0),
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    _count != 1
                                        ? new IconButton(
                                            icon: new Icon(Icons.remove),
                                            onPressed: () {
                                              decre();
                                            },
                                          )
                                        : new Container(),
                                    new Text(_count.toString()),
                                    new IconButton(
                                        icon: new Icon(Icons.add),
                                        onPressed: () {
                                          incre();
                                        })
                                  ],
                                ))
                          ]),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        )
      )
    ;
  }


}
