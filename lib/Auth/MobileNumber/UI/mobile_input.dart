import 'package:anywash_delivery/Components/entry_field.dart';
import 'package:anywash_delivery/Locale/locales.dart';
import 'package:anywash_delivery/Themes/colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../login_navigator.dart';

class MobileInput extends StatefulWidget {
  @override
  _MobileInputState createState() => _MobileInputState();
}

class _MobileInputState extends State<MobileInput> {
  final TextEditingController _controller = TextEditingController();
  String? isoCode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: <Widget>[
          CountryCodePicker(
            onChanged: (value) {
              isoCode = value.code;
            },
            builder: (value) => buildButton(value),
            initialSelection: '+1',
            textStyle: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(fontWeight: FontWeight.bold),
            showFlag: false,
            showFlagDialog: true,
            favorite: ['+91', 'US'],
          ),
          SizedBox(
            width: 10.0,
          ),
          //takes phone number as input
          Expanded(
            child: EntryField(
              controller: _controller,
              keyboardType: TextInputType.number,
              readOnly: false,
              hint: AppLocalizations.of(context)!.mobileText,
              maxLength: 10,
              border: InputBorder.none,
            ),
          ),

          //if phone number is valid, button gets enabled and takes to register screen
          TextButton(
            child: Text(
              AppLocalizations.of(context)!.continueText!,
              style: Theme.of(context).textTheme.button,
            ),
            style: TextButton.styleFrom(
              backgroundColor: kMainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, LoginRoutes.registration);
            },
          ),
        ],
      ),
    );
  }

  buildButton(CountryCode? isoCode) {
    return Row(
      children: <Widget>[
        Text(
          '$isoCode',
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(fontWeight: FontWeight.w600, fontSize: 14),
        ),
      ],
    );
  }
}
