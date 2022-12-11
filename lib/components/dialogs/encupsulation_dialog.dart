import 'package:flutter/material.dart';
import 'package:zabihtk/app_repo/product_state.dart';
import 'package:zabihtk/locale/localization.dart';
import 'package:zabihtk/utils/app_colors.dart';
import 'package:provider/provider.dart';


class EncupsulationDialog extends StatefulWidget {
 


  @override
  _EncupsulationDialogState createState() => _EncupsulationDialogState();
}

class _EncupsulationDialogState extends State<EncupsulationDialog> {

  @override
  Widget build(BuildContext context) {
     final productState = Provider.of<ProductState>(context);
    return  LayoutBuilder(builder: (context,constraints){
 return AlertDialog(
   contentPadding: EdgeInsets.fromLTRB(0.0,0.0,0.0,0.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      content: productState.encapsulationList.length > 8 ? Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
      
           Container(
              decoration: BoxDecoration(
                   color: cAccentColor,
                      borderRadius: BorderRadius.only(
                        topLeft:  Radius.circular(10.00),
                        topRight:  Radius.circular(10.00),
                      ),
                      border: Border.all(color: cAccentColor)),
             alignment: Alignment.center,
             width: MediaQuery.of(context).size.width,
             height: 40,
          
             child: Text(AppLocalizations.of(context).encupsulation,style: TextStyle(
               color: cWhite,fontSize: 16,
               fontWeight: FontWeight.w700
             ),),
           ),
           Expanded(
             child: Consumer<ProductState>(
               builder: (context,productState,child){
             return ListView.builder(
             shrinkWrap: true,
              itemCount: productState.encapsulationList.length,
              itemBuilder: (context,index){
                return Column(
                 children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        productState.updateChangesOnEncapsulationList(index);
                        productState.updateTotalCost();
                        Navigator.pop(context);
                      },
                      child:  Row(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(3)),
                          ClipOval(
                            child: Image.network(
                              productState.encapsulationList[index].optionsPhoto,
                              fit: BoxFit.fill,
                              width: 35,
                              height: 35,
                            ),
                          ),
                          Padding(padding: EdgeInsets.all(5)),
                          Container(
                            alignment: Alignment.centerRight,
                            height: 40,
                            child: Text(productState.encapsulationList[index].optionsName,style: TextStyle(
                                color: cBlack,
                                fontSize: 14,fontWeight: FontWeight.w400
                            ),),
                          )
                        ],
                      ),
                    ),
                    index != productState.encapsulationList.length - 1 ? Divider():
                    Container()
                 ],
                );
              }
             );
               }
             ),
           )
        ],
      ) : SingleChildScrollView(
        child:  Column(
          children: <Widget>[
      
             Container(
                decoration: BoxDecoration(
                     color: cAccentColor,
                       borderRadius: BorderRadius.only(
                          topLeft:  Radius.circular(10.00),
                          topRight:  Radius.circular(10.00),
                        ),
                        border: Border.all(color: cAccentColor)),
               alignment: Alignment.center,
               width: MediaQuery.of(context).size.width,
               height: 40,
            
               child: Text( AppLocalizations.of(context).encupsulation,style: TextStyle(
                 color: cWhite,fontSize: 16,
                 fontWeight: FontWeight.w700
               ),),
             ),
          LimitedBox(
            maxHeight: productState.encapsulationList.length * 60.0,
            child: Column(
               mainAxisSize: MainAxisSize.min,
              children:  <Widget>[
                   Consumer<ProductState>(
                     builder: (context,productState,child){
            return ListView.builder(
              shrinkWrap: true,
                    itemCount: productState.encapsulationList.length,
                    itemBuilder: (context,index){
                      return Column(
                       children: <Widget>[
                          GestureDetector(
                            onTap: (){
                              productState.updateChangesOnEncapsulationList(index);
                              productState.updateTotalCost();
                              Navigator.pop(context);
                            },
                            child: Row(
                              children: <Widget>[
                                Padding(padding: EdgeInsets.all(3)),
                                ClipOval(
                                  child: Image.network(
                                    productState.encapsulationList[index].optionsPhoto,
                                    fit: BoxFit.fill,
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(5)),
                                Container(
                                  alignment: Alignment.centerRight,
                                  height: 40,
                                  child: Text(productState.encapsulationList[index].optionsName,style: TextStyle(
                                      color: cBlack,
                                      fontSize: 14,fontWeight: FontWeight.w400
                                  ),),
                                )
                              ],
                            ),
                          ),
                          index != productState.encapsulationList.length - 1 ? Divider():
                          Container()
                       ],
                      );
                    }
            );
                     }
                   ),
                 ],
               ),
             )
          ],
        )),
      
    );
    });
  }
}
