import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_redirect/store_redirect.dart';



import 'NoInternet.dart';
import 'connectivity_provider.dart';
class Rate extends StatefulWidget {
  @override
  _RateState createState() => _RateState();
}

class _RateState extends State<Rate> {
  @override
  void initState() {
    Provider.of<ConnectivityProvider>(context,listen: false).startMonitoring();
    //getrateusprocess();

  }

  @override
  Widget build(BuildContext context) {
    return
      Consumer<ConnectivityProvider>(
        builder: (context,model,child){
          if(model.isOnline!=null){
            return model.isOnline?
            StoreRedirect.redirect(
              androidAppId: 'com.intpro.intpro_app',
              iOSAppId: '',
            )
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
