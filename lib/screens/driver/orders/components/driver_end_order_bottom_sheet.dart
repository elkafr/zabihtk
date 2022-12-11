import 'package:flutter/material.dart';
import 'package:zabihtk/components/buttons/custom_button.dart';
import 'package:zabihtk/locale/localization.dart';
import 'package:zabihtk/utils/app_colors.dart';


class DriverEndOrderBottomSheet extends StatefulWidget {
  final Function onPressedConfirmation;

  const DriverEndOrderBottomSheet({Key key, this.onPressedConfirmation})
      : super(key: key);
  @override
  _DriverEndOrderBottomSheetState createState() => _DriverEndOrderBottomSheetState();
}

class _DriverEndOrderBottomSheetState extends State<DriverEndOrderBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: constraints.maxHeight * 0.05),
              child: Icon(
                Icons.not_interested,
                size: constraints.maxHeight * 0.4,
                color: cLightRed,
              )),
          Container(
            margin:
                EdgeInsets.symmetric(vertical: constraints.maxHeight * 0.05),
            child: Text(
              AppLocalizations.of(context).wantToEndOrder,
              style: TextStyle(
                  color: cBlack, fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
               Container(
                    width: MediaQuery.of(context).size.width *0.3,
                    height: 50,
                    child: CustomButton(
                      buttonOnDialog: true,
                        btnStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: cWhite),
                      
                    btnLbl: AppLocalizations.of(context).ok,
                    onPressedFunction: () async {
                      widget.onPressedConfirmation();
                    })),
              
              Spacer(
                flex: 1,
              ),
             
               Container(
                    width: MediaQuery.of(context).size.width *0.3,
                    height: 50,
                    child: CustomButton(
                      buttonOnDialog: true,
                         btnStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: cBlack),
                    
                      btnLbl: AppLocalizations.of(context).cancel,
                      btnColor: cAccentColor,
                      borderColor: cAccentColor,
                      onPressedFunction: () {
                        Navigator.pop(context);
                      })),
              Spacer(
                flex: 2,
              ),
            ],
          )
        ],
      );
    });
  }
}
