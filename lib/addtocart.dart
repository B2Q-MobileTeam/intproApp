import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intpro_app/Url.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'NoInternet.dart';
import 'Shippingform.dart';
import 'connectivity_provider.dart';
import 'dashboard.dart';
import 'drawer.dart';
import 'listofbrands.dart';
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
  final String carttid,
      cartid,
      title,
      pro_name,
      brand_name,
      cat_name,
      pro_id,
      b_name;

  Cart(
      {Key key,
      this.carttid,
      this.cartid,
      this.title,
      this.pro_name,
      this.brand_name,
      this.cat_name,
      this.pro_id,
      this.b_name})
      : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Add> _cartList = List<Add>();
  int counter = 0;
  int _count = 1;
  String userid, name_pay, mobileno_pay, email_pay, pricefinal_pay;
  int count_increase;
  int count_decrease;
  String totalprice = '0';
  String cartcountsss;
  String brand_brandname;
  String catcat_value;
  String re_brand_id;
  String Show_drop_down_type, Show_drop_down_shades;
  String eg_shade_id;
  var eg_pro_id;
  bool showthirddropdown = false;
  String add_cart_brandid,add_cart_proid;

  List datapro = List();
  List typepro = List();
  List shadespro = List();
  String selectedvalue, typevalue, shadevalue;
  var pro_id, a, priceid;
  String count_changed;

  var price = '';
  var amount, b;
  String img;
  var cartcount="0", token;
  String remaining_woods, Category_name_display;

  //thickness api

  Future<String> fetchcart() async {
    var cart = widget.carttid;
    remaining_woods = widget.title;

    print(' cart $cart $remaining_woods');

    print('url ${ApiCall.ProductMeasure}');

    if (remaining_woods == "plywoods") {
      brand_brandname = widget.b_name;

      SharedPreferences prefs = await SharedPreferences.getInstance();

      final http.Response response = await http.post(
        Uri.parse(ApiCall.ProductMeasure),
        body: {'brand_id': widget.carttid},
      );
      var resJson = json.decode(response.body);
      print('object $resJson');
      var product = resJson['product_measure'];
      img = product[0]['cat_img'];
      print('img $img');
      print('val $resJson');

      // print('product $product');
      setState(() {
        userid = (prefs.getString('token'));
        print('share $userid');
        datapro = product;
      });
    } else {
      remaining_woods = widget.cat_name;
      brand_brandname = widget.pro_name;
      Category_name_display = widget.brand_name;
      catcat_value = Category_name_display;

      SharedPreferences prefs = await SharedPreferences.getInstance();

      final http.Response response = await http.post(
        Uri.parse(ApiCall.ProductMeasure),
        body: {'pro_id': widget.pro_id},
      );
      var resJson = json.decode(response.body);
      print('object product mesasure response  $resJson');
      var product = resJson['product_measure'];
      img = product[0]['cat_img'];
      print('img $img');

      // print('product $product');
      setState(() {
        userid = (prefs.getString('token'));
        print('share $userid');
        datapro = product;
      });
    }

    // print('object $datapro');
  }

  //end thicknes api

  //type api

  Future<String> fetchtype() async {
    var cart = widget.carttid;
    print(' cart $selectedvalue');

    print('type ${ApiCall.ProductType}');

    final http.Response response = await http.post(
      Uri.parse(ApiCall.ProductType),
      body: {'m_id': selectedvalue},
    );
    var resJson = json.decode(response.body);
    print('type product  $resJson');
    Show_drop_down_type = resJson['apicall'];
    print('show_dropdown $Show_drop_down_type');

    var types = resJson['product_types'];

    // print('type $types');
    setState(() {
      typepro = types;
    });
    // print('producttype $typepro');
  }

  //end type api
//shades api

  Future<String> fetchshades() async {
    var cart = widget.carttid;
    print(' shadeid $eg_shade_id');
    print('type ${ApiCall.ProductShades}');

    final http.Response response = await http.post(
      Uri.parse(ApiCall.ProductShades),
      body: {
        'shade_id': eg_shade_id,
      },
    );
    var resJson = json.decode(response.body);
    print('type product $resJson');
    if (Show_drop_down_type == "true") {
      showthirddropdown = true;
    }

    var shades = resJson['product_shade'];

    // print('type $types');
    setState(() {
      shadespro = shades;
    });
    // print('producttype $typepro');
  }

  //shades api end
  //price api
  Future<String> fetchprice() async {
    var cart = widget.carttid;
    print(' cart $cart');
    print('price ${ApiCall.ProductPrice}');

    if (remaining_woods == "plywoods") {
      print('plywood product price $selectedvalue $re_brand_id $typevalue $eg_pro_id');
      re_brand_id = widget.carttid;
      final http.Response response = await http.post(
        Uri.parse(ApiCall.ProductPrice),
        body: {
          'm_id': selectedvalue,
          'brand_id': re_brand_id,
          'type_id': typevalue,
          'pro_id': eg_pro_id
        },
      );
      var resJson = json.decode(response.body);
      print('product_price  $resJson');
      var types = resJson['product_price'];
      print('price $types');

      price = types[0]['price'];
      pro_id = types[0]['price_id']; //proid ku price id
      priceid = types[0]['pro_id']; //priceid ku proid
      add_cart_brandid=types[0]['brand_id'];
      print('prices $price');
      print('pro_id $pro_id');//price_id
      print('price_id $priceid');//pro_id

      setState(() {
        amount = price;
        print('amout is $amount');
        calculationpart();
        //fetchprice();
      });
    } else {
      re_brand_id = widget.cartid;
      print('brandid $re_brand_id');
      print('m_id $selectedvalue');
      print('type value $typevalue');
      print('proid $eg_pro_id');
      final http.Response response = await http.post(
        Uri.parse(ApiCall.ProductPrice),
        body: {
          'm_id': selectedvalue,
          'brand_id': re_brand_id,
          'type_id': typevalue,
          'pro_id': eg_pro_id
        },
      );
      var resJson = json.decode(response.body);
      print('product_price  $resJson');
      var types = resJson['product_price'];
      print('price $types');

      price = types[0]['price'];
      pro_id = types[0]['price_id']; //proid ku price id
      priceid = types[0]['pro_id']; //priceid ku proid
     add_cart_brandid=types[0]['brand_id'];
      print('prices $price');
      print('pro_id $pro_id');

      setState(() {
        amount = price;
        print('amout is $amount');
        calculationpart();
        //fetchprice();
      });
    }
  }

  //end price api

  //payment instamojo process

  //end payment instamojo

  void cleardataprocess() {
    selectedvalue = null;
    typevalue = null;
    totalprice = "0";
    shadevalue=null;
    _count = 1;
  }

  //cart api
  Future<String> fetchpro() async {
    print('cart price ${ApiCall.AddToCart}');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = (prefs.getString('token'));
      print('userid $userid');
    });
    print('values in add to cart $add_cart_brandid $priceid $userid $pro_id $totalprice ${_count.toString()} ');
    final http.Response response = await http.post(
      Uri.parse(ApiCall.AddToCart),
      body: {

        'brand_id':add_cart_brandid,
        'pro_id':priceid,
        'price_id': pro_id,
        'amount': totalprice,
        'quantity': _count.toString(),
        'user_id': userid
      },
    );
    var resJson = json.decode(response.body);
    print('add to cart $resJson');
    String count_changedd = resJson["data"];
    count_changed = count_changedd;
    print('countchanged $count_changed');
    setState(() {
      cartcount = "";
      cartcount = count_changed;
    });

    print('count changed $count_changed');

    Fluttertoast.showToast(
        msg: "Added to Cart",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        fontSize: 16.0);

    cleardataprocess();
  }

  void validateprocess() {
    if (typevalue == null) {
      Fluttertoast.showToast(
          msg: "Please select product type",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          fontSize: 16.0);
    } else if (selectedvalue == null) {
      Fluttertoast.showToast(
          msg: "Please select product thickness",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          fontSize: 16.0);
    } else {
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

    final http.Response response = await http.post(
      Uri.parse(ApiCall.CartDetails),
      body: {
        'user_id': token,
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
    Provider.of<ConnectivityProvider>(context,listen: false).startMonitoring();
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
    String brandidcart = re_brand_id;
    String ship_proid = pro_id;
    String ship_priceid = priceid;
    String ship_qty = _count.toString();
    String payAmnt = totalprice;
    String ship_purpose = remaining_woods;
    return
      Consumer<ConnectivityProvider>(
        builder: (context,model,child){
          if(model.isOnline!=null){
            return model.isOnline?
            WillPopScope(
                onWillPop: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homee(),
                    ),(route)=>false
                  );
                },


                child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      elevation: 0.0,
                      title: Text('Add to cart',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 22.0,
                              color: Colors.white)),
                      actions: [
                        Stack(
                          children: <Widget>[
                            new IconButton(
                              icon: new Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) => MyOrder()),(route)=>false);
                                print('cartcount $cartcount');
                              },
                            ),
                            cartcount == "0"
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
                    bottomSheet: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            child: Text('Add to Cart'),
                            onPressed: () {
                              validateprocess();
                            },
                          ),
                        ),
                        Expanded(
                            child: RaisedButton(
                              onPressed: () {
                                int totaltotalprice=int.parse(totalprice);
                                print("total $totaltotalprice");
                                if (typevalue == null) {
                                  Fluttertoast.showToast(
                                      msg: "Please select product type",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 2,
                                      fontSize: 16.0);
                                } else if (selectedvalue == null) {
                                  Fluttertoast.showToast(
                                      msg: "Please select product thickness",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 2,
                                      fontSize: 16.0);
                                } else if(totalprice==0){
                                  Fluttertoast.showToast(
                                      msg: "Please select shades",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIos: 2,
                                      fontSize: 16.0);
                                }else if(totaltotalprice >=10000){
                                  Fluttertoast.showToast(
                                      msg: 'Your Maximum Limit 10000',
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.TOP,
                                      timeInSecForIos: 1,
                                      fontSize: 16.0);

                                }else{
                                  Navigator.pop(context);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ShippingForm(
                                              ship_brandid: brandidcart,
                                              ship_productid: ship_proid,
                                              ship_price_id: ship_priceid,
                                              ship_quantity: ship_qty,
                                              ship_amt: payAmnt,
                                              shippurpose: ship_purpose,
                                              ship_mode: "buynow")),(route)=>false);

                                  print('add to cart to $brandidcart $ship_proid $ship_priceid $ship_qty $payAmnt $ship_purpose');
                                }
                              },
                              child: Text("Buy Now"),
                              color: Theme.of(context).colorScheme.primary,
                              textColor: Colors.white,
                            )),
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
                                        left: 30.0, top: 10.0, bottom: 20.0, right: 10),
                                    child: Center(
                                      child: Text("${remaining_woods}",
                                          style: TextStyle(
                                              fontSize: 22.0, fontWeight: FontWeight.w800)),
                                    )),
                                catcat_value == null
                                    ? Container()
                                    : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, top: 5.0, bottom: 5.0),
                                  child: Text("${catcat_value}",
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.normal)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30.0, top: 5.0, bottom: 10.0),
                                  child: Text("${brand_brandname}",
                                      style: TextStyle(
                                          fontSize: 18.0, fontWeight: FontWeight.w400)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(bottom: 5),
                                        child: DropdownButton(
                                            isExpanded: true,
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
                                                shadevalue=null;
                                                totalprice = '0';
                                                _count = 1;
                                                fetchtype();
                                                print('selected $selectedvalue');
                                              });
                                            }),
                                      ),
                                      Container(
                                        child: DropdownButton(
                                            isExpanded: true,
                                            value: typevalue,
                                            items: typepro.map((item) {
                                              return DropdownMenuItem(
                                                  onTap: () {
                                                    eg_pro_id = item['pro_id'];
                                                    eg_shade_id = item['shade_id'];
                                                  },
                                                  value: item['type_id'],
                                                  child: Text(item['type']));
                                            }).toList(),
                                            hint: Text('Select  type'),
                                            onChanged: (value) {
                                              setState(() {
                                                if (Show_drop_down_type == "true") {
                                                  typevalue = value;
                                                  shadevalue=null;
                                                  _count = 1;
                                                  totalprice = '0';
                                                  fetchshades();
                                                } else {
                                                  typevalue = value;
                                                  fetchprice();
                                                }
                                              });
                                              print('typeid $typevalue');
                                            }),
                                      ),
                                      showthirddropdown
                                          ? Container(
                                        child: DropdownButton(
                                            isExpanded: true,
                                            value: shadevalue,
                                            items: shadespro.map((item) {
                                              return DropdownMenuItem(
                                                  onTap: () {
                                                    eg_pro_id = item['pro_id'];
                                                    selectedvalue = item['m_id'];
                                                    re_brand_id = item['brand_id'];
                                                    typevalue = item['type_id'];
                                                  },
                                                  value: item['shade_id'],
                                                  child: Text(item['shade']));
                                            }).toList(),
                                            hint: Text('Select Shades'),
                                            onChanged: (value) {
                                              setState(() {
                                                shadevalue = value;
                                                fetchprice();
                                              });
                                              print('typeid $typevalue');
                                            }),
                                      )
                                          : Container()
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
                    )))
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
}
