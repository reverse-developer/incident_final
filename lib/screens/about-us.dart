import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:incident_report/styles/styles.dart';
import 'package:incident_report/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            print(SizeConfig.imageSizeMultiplier);
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    color: Color(0xff53A5CE),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Image.asset('assets/bigger.png'),
                          Text(
                            'About Us',
                            style: BigBoldHeading.copyWith(color: Colors.white),
                          ),
                          SizedBox(
                            height: 2.52 * SizeConfig.heightMultiplier,
                          ),
                          CustomListTitle(
                            'Tad\'s Story ',
                            () {
                              _launchInWebViewOrVC(
                                  'https://www.bullyingendshere.ca/tads-story');
                            },
                            //  () => setState(() => _selectedTab =1),
                          ),
                          SizedBox(
                            height: 2.52 * SizeConfig.heightMultiplier,
                          ),
                          CustomListTitle(
                            'Board of Directors',
                            () {
                              _launchInWebViewOrVC(
                                  'https://www.bullyingendshere.ca/board-of-directors');
                            },
                            //  () => setState(() => _selectedTab =1),
                          ),
                          SizedBox(
                            height: 2.52 * SizeConfig.heightMultiplier,
                          ),
                          CustomListTitle(
                            'Our Mission',
                            () {
                              _launchInWebViewOrVC(
                                  'https://www.bullyingendshere.ca/our-mission');
                            },
                            //  () => setState(() => _selectedTab =1),
                          ),
                          SizedBox(
                            height: 2.52 * SizeConfig.heightMultiplier,
                          ),
                          CustomListTitle(
                            'Media and Awards',
                            () {
                              _launchInWebViewOrVC(
                                  'https://www.bullyingendshere.ca/media-awards');
                            },
                            //  () => setState(() => _selectedTab =1),
                          ),
                          SizedBox(
                            height: 2.52 * SizeConfig.heightMultiplier,
                          ),
                          CustomListTitle(
                            'Photos of Tad',
                            () {
                              _launchInWebViewOrVC(
                                  'https://www.bullyingendshere.ca/photos-of-tad');
                            },
                            //  () => setState(() => _selectedTab =1),
                          ),
                          SizedBox(
                            height: 2.52 * SizeConfig.heightMultiplier,
                          ),
                          CustomListTitle(
                            'Contact Tad',
                            () {
                              _launchInWebViewOrVC(
                                  'https://www.bullyingendshere.ca/contact-tad');
                            },
                            //  () => setState(() => _selectedTab =1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class CustomListTitle extends StatelessWidget {
  String _text;
  Function _onTap;

  CustomListTitle(this._text, this._onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
          height: 7 * SizeConfig.heightMultiplier,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color(0xff2A2626)),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              _text,
              style: WhiteAboutHeading,
            ),
          ),
        ),
      ),
    );
  }
}
