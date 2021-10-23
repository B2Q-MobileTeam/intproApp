
import 'package:flutter/material.dart';

import '../PdfViewPge.dart';

class DetailOrderPage extends StatefulWidget {
  String dorderid,dtransactionid,dtransactiondate,dproduct,
      dbrand,ditem,dprice,dquantity,damount,dshipping,dspecification,dinvoice,dinvoicename;

  DetailOrderPage({this.dshipping, this.dspecification, this. dorderid,this.dtransactionid,this.dtransactiondate,
                  this.dproduct,this.dbrand,this.ditem,this.dprice,this.dquantity,this.damount,this.dinvoice,this.dinvoicename});

  @override
  DetailOrderPageState createState() => DetailOrderPageState();
}

class DetailOrderPageState extends State<DetailOrderPage> {

  var shipping_data;


  @override
  Widget build(BuildContext context) {
    String disproduct = widget.dproduct;
    String disorderid = widget.dorderid;
    String distransactionid = widget.dtransactionid;
    String distransactiondate = widget.dtransactiondate;
    String disbrand = widget.dbrand;
    String disitem = widget.ditem;
    String disprice = widget.dprice;
    String disquantity = widget.dquantity;
    String disamount = widget.damount;
    String dinvoice = widget.dinvoice;
    String dinvoicename=widget.dinvoicename;


    var shippingdetails="";
    var specificationdetails="";
    var shipping_data = widget.dshipping;
    String splitingdata_ship = shipping_data;
    var shipping_values = splitingdata_ship.split("+");
    print("data $shipping_values");

    for(int i=0;i<shipping_values.length;i++){
      shippingdetails+=shipping_values[i]+"\n";
    }
    print(shippingdetails);
    var specification_data = widget.dspecification;
    String splitingdata_speci = specification_data;
    var specification_values = splitingdata_speci.split("+");
    print("data $specification_values");

    for(int i=0;i<specification_values.length;i++){
      specificationdetails+=specification_values[i]+"\n";
    }
    print(specificationdetails);


    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(

        children: <Widget>[
          Container(

            padding: EdgeInsets.all(16),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(

                          child: Text(
                            'Product Details',

                            style: TextStyle(

                                fontSize: 18,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          child:OutlinedButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PdfViewPage(

                                dinvoiceview:dinvoice,
                                dinvoicename:dinvoicename,

                              )));

                            },
                            child: Text("View Invoice"),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      color: Colors.blueGrey,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          Text(
                            "Product - $disproduct",

                            style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff333333),
                                ),
                          ),
                          Text(
                            "Brand - $disbrand",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff333333),
                            ),
                          ),
                          Text(
                            "Item - $disitem",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff333333),
                            ),
                          ),
                          Text(
                            "Qty - $disquantity",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff333333),
                            ),
                          ),
                          Text(
                            "Price - $disprice",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff333333),
                            ),
                          ),
                          Text(
                            "Amount - $disamount",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(16),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(

                      child: Text(
                        'Specification',

                        style: TextStyle(

                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Divider(
                      color: Colors.blueGrey,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          Text(
                            "$specificationdetails",

                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff333333),
                            ),
                          ),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.all(16),
            child: Card(
              elevation: 10,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(

                      child: Text(
                        'Shipping Details',

                        style: TextStyle(

                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Divider(
                      color: Colors.blueGrey,
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: <Widget>[
                          Text(
                            "$shippingdetails",

                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
