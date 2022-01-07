import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/dart model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: home(),
    );
  }
}

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  var date;
  List<Transactions> transactions = [];
  String url = "https://run.mocky.io/v3/cb03f6c9-de66-4b28-94b1-6c063ceb6153";
  Future? objfuture;
  Future<Model_class> apiCall() async {
    Model_class? objHome_model;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      objHome_model = Model_class.fromJson(data);
      print(response.body);
      setState(() {
        date = objHome_model?.date!;

        for (int i = 0; i < objHome_model!.transactions!.length; i++) {
          transactions!.add(objHome_model.transactions![i]);
        }
      });
    }
    return objHome_model!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    objfuture = apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: objfuture,
          builder: (context, snap) {
            if (snap.hasData) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Last 5 Transactions of " + date,
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: transactions!.length,
                        itemBuilder: (c, i) {
                          return Card(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(
                                  top: 15, bottom: 10, left: 20, right: 20),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(transactions![i].dateFull!)
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/images/sbi logo.png",
                                            height: 50,
                                            width: 50,
                                          ),
                                          Spacer(
                                            flex: 1,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(transactions![i].paymentMode!),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Text(transactions![i]
                                                  .transactionType!),
                                              SizedBox(
                                                height: 6,
                                              ),
                                              Text(transactions![i].beneficiary!)
                                            ],
                                          ),
                                          Spacer(
                                            flex: 6,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                transactions![i].amount!,
                                                style: TextStyle(fontSize: 14),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              );
            } else {
              return Container(child: Center(child: CircularProgressIndicator()));
            }
          },
        ),
      ),
    );
  }
}
