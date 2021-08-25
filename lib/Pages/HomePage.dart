import 'package:flutter/material.dart';
import 'package:mycurrentlocation/Provider/MyLocationProvider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Provider.of<MyLocationProvider>(context, listen: false)
        .determinePermissionBeforeGetLocation(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MyLocationProvider>(
      builder: (context, model, child) {
        return (model.latLang == "" && model.myAddress == "") &&
                (model.noLocation == false)
            ? Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : model.noLocation == true
                ? Scaffold(
                    appBar: AppBar(
                      title: Text("No Location"),
                    ),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Provider.of<MyLocationProvider>(context,
                                      listen: false)
                                  .determinePermissionBeforeGetLocation(
                                      context);
                            },
                            child: Text("RECHECK LOCATION"),
                          ),
                        ],
                      ),
                    ),
                  )
                : Scaffold(
                    appBar: AppBar(
                      title: Text("Home Page"),
                    ),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Provider.of<MyLocationProvider>(context,
                                      listen: false)
                                  .determinePermissionBeforeGetLocation(
                                      context);
                            },
                            child: Text("MY CURRENT LOCATION"),
                          ),
                          if (model.latLang != "") ...[
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Your current Latitude & Longitude is: ${model.latLang}",
                            ),
                            if (model.myAddress != "") ...[
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Your address is: ${model.myAddress}",
                              ),
                            ],
                          ],
                        ],
                      ),
                    ),
                  );
      },
    );
  }
}
