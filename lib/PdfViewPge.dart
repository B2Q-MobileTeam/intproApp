

import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intpro_app/model/DetailOrderPage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'NoInternet.dart';
import 'connectivity_provider.dart';
import 'model/myorderlist.dart';

class PdfViewPage extends StatefulWidget {
  String dinvoiceview,dinvoicename;

  PdfViewPage({this.dinvoiceview,this.dinvoicename});



  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  String progress;
  bool downloading = false;
  var progressString = "";

  bool _isLoading = true;
  PDFDocument _pdf;
//  final imgUrl="https://www.binary2quantumsolutions.com/intpro/uploaded/invoice.pdf";
  var dio=Dio();

//print({widget.dinvoiceview});

  void _loadFile() async {
    String pdfurl = widget.dinvoiceview;
    _pdf = await PDFDocument.fromURL(
        pdfurl);

    setState(() {
      _isLoading = false;
    });
  }
  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context,listen: false).startMonitoring();
    super.initState();
    _loadFile();

  }



  void getPermission() async{
    print("get permission");
    String pdfurl = widget.dinvoiceview;
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);


  }
  @override
  Widget build(BuildContext context) {
    String pdfurls=widget.dinvoiceview;
    String invoice_name=widget.dinvoicename;
    return Consumer<ConnectivityProvider>(
      builder: (context,model,child){
        if(model.isOnline!=null){
          return model.isOnline?
          WillPopScope(
              onWillPop: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyOrderListprocess(),
                    ),(route)=>false
                );
              },
      child:    Scaffold(
            appBar: AppBar(
              title: Text('Invoice'),
              backgroundColor: Colors.blue,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: (){
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyOrderListprocess(),
                      ),(route)=>false
                  );
                },
              ),
            ),
            body:  Container(
                child: _isLoading
                    ? Center(child: CircularProgressIndicator())
                    :
                PDFViewer(document: _pdf)
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: ()async{

                String path = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
                String fullpath = "$path/$invoice_name";
                print(fullpath);
                download2(dio,pdfurls,fullpath);
              },
              child: Icon(Icons.download_rounded),
              backgroundColor: Colors.blueGrey,
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




  Future download2(Dio dio,String url,String savepath)async{
    try{
      Response response = await dio.get(
        url,
        onReceiveProgress: (rec,total){
          print("Rec: $rec , Total: $total");

          setState(() {
           _isLoading=true;
            progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
          });
      },
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status){
              return status < 500;
            }
        ),);
      File file=File(savepath);
      var raf = file.openSync(mode:FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

    }catch(e){
      print("error is ");
      print(e);
    }
    setState(() {
      _isLoading=false;
      print("download completed");
      Fluttertoast.showToast(
          msg: "Downloaded Successfully ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIos: 5,
          fontSize: 20.0);
    });

  }


}


