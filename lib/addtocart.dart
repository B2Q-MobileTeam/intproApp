import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Dashboardfragment.dart';
import 'Shippingform.dart';
import 'drawer.dart';
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
  var pro_id, a,priceid;
  String count_changed;

  var price = '';
  var amount, b;
  String img;
  var cartcount,token;

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
    print('product_price  $resJson');
    var types = resJson['product_price'];
    print('price $types');

    price = types[0]['price'];
    pro_id = types[0]['price_id'];//proid ku price id
    priceid=types[0]['pro_id'];//priceid ku proid

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

  //end payment instamojo




  void cleardataprocess() {
    selectedvalue=null;
    typevalue=null;
    totalprice="0";
    _count=1;
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
print('values in add to cart $pro_id $totalprice ${_count.toString()} ');
    final http.Response response = await http.post(
      Uri.parse(url),
      body: {
        'price_id': pro_id,
        'amount': totalprice,
        'quantity': _count.toString(),
        'user_id': "80"
      },
    );
    var resJson = json.decode(response.body);
    print('add to cart $resJson');
    String count_changedd= resJson["data"];
    count_changed=count_changedd;
    print('countchanged $count_changed');
    setState(() {
      cartcount="";
      cartcount=count_changed;
    });
    // DashboardFragment.of(context).checkprocess(count_changed);
   // DashboardFragment.of(context).checkprocess(count_changed);

    print('count changed $count_changed');
    //int count_changed = count_changedd;

    Fluttertoast.showToast(
        msg: "Added to Cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0);

    cleardataprocess();
  }

  void validateprocess() {
    if(typevalue==null){
      Fluttertoast.showToast(
          msg: "Please select product type",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          fontSize: 16.0);

    }else if(selectedvalue == null){
      Fluttertoast.showToast(
          msg: "Please select product thickness",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          fontSize: 16.0);
    }else{
      fetchpro();

    }
  }

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString('token');
      print("token $token");
      getcartdetail();
    });
  }

  Future getcartdetail() async {
    print("cart 2");
    var url = 'https://www.binary2quantumsolutions.com/intpro/cart_details.php';
    final http.Response response = await http.post(
      Uri.parse(url),
      body: {
        'user_id': "80",
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
      cartcount = cartcart;
    });
    fetchcart();
    print('item cart 3');

    print('items count $cartcount');
  }
  //endn cart api

  @override
  void initState() {
   getEmail();
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
    String brandidcart=widget.carttid;
    String ship_proid=pro_id;
    String ship_priceid=priceid;
    String ship_qty=_count.toString();
    String payAmnt = totalprice;
    String ship_purpose=widget.title;



    return Scaffold(
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
        drawer:Drawer_main(),
        bottomSheet: Row(
          children: <Widget>[
            Expanded(
             child:
                  RaisedButton(
                    child: Text('Add to Cart'),
                    onPressed: (){
                      // myModel.doaddproduct();
                     // DashboardFragment.of(context).cartcount="34";

validateprocess();
                      // fetchpro();
                      // cleardataprocess();

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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShippingForm(
                          ship_brandid:brandidcart,
                          ship_productid:ship_proid,
                          ship_price_id:ship_priceid,
                          ship_quantity:ship_qty,
                          ship_amt:payAmnt,
                          shippurpose:ship_purpose,
                          ship_mode:"buynow"
                        )));
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
      );
  }
}

