import 'package:flutter/material.dart';
import 'package:logistics/logistics.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      height: 80,
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        child:
            "Copyright ©${DateTime.now().year} Finsel DGI Limited. All rights reserved"
                .highlightedText(
                    style: appTextStyle(
                      color: Colors.black,
                      size: getProportionateScreenHeight(13.4),
                    ),
                    highlighted: [
              TextHighlightObject(
                text: "Finsel DGI Limited",
                style: appTextStyle(
                  color: context.theme.primaryColor,
                  decoration: TextDecoration.underline,
                  size: getProportionateScreenHeight(13.4),
                ),
                onPressed: () {
                  UrlService.launchURL("https://www.pasby.africa/company");
                },
              )
            ]),
      ),
    );
  }
}
