import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:zabihtk/app_repo/product_state.dart';

import 'package:zabihtk/locale/localization.dart';
import 'package:zabihtk/models/sacrifice.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:provider/provider.dart';

class SacrificesItem extends StatelessWidget {
  final Sacrifice sacrifice;

  const SacrificesItem({Key key, this.sacrifice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productState = Provider.of<ProductState>(context);
    return GestureDetector(
      onTap: () {
        productState.setProductId(sacrifice.adsMtgerId);
        productState.setProductTitle(sacrifice.adsMtgerName);
        Navigator.pushNamed(context, '/product_screen');
      },
      child: Container(
          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
          height: MediaQuery.of(context).size.height*.18,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(25.00),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300],
                blurRadius: 1.0,
              )
            ],
            color: cWhite,
            border: Border.all(color: Color(0xff1F61301A), width: 1.0),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    child: Image.network(
                      sacrifice.adsMtgerPhoto,
                      height: MediaQuery.of(context).size.height*.18,
                      width:  MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                  ),


                  Expanded(child: Container(

                    width: MediaQuery.of(context).size.width,


                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.00),
                          bottomRight: Radius.circular(25.00)
                      ),
                      border: Border.all(color: cPrimaryColor),
                      color: cPrimaryColor,

                    ),

                    padding: EdgeInsets.only(top: 15),
                    child: Center(child: Text(
                      sacrifice.adsMtgerName,
                      style: TextStyle(
                          color: cWhite, fontSize: 18, fontWeight: FontWeight.w700),
                    ),),

                  )),

                ],
              ),
              Positioned.fill(
                  top: MediaQuery.of(context).size.height*.16,


                  child:  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 88,
                      height: 31,
                      padding: EdgeInsets.only(top: 7,bottom: 5,right: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16.00),
                          ),
                          color: cAccentColor),
                      child: Center(child: Text(
                        '${sacrifice.adsMtgerPrice} ${AppLocalizations.of(context).sr}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'HelveticaNeueW23forSKY',
                          fontWeight:FontWeight.bold,

                        ),
                      ),),
                    ),
                  ))
            ],
          )
      ),
    );
  }
}
