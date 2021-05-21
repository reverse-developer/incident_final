import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:incident_report/home.dart';
import 'package:incident_report/screens/about-us.dart';
import 'package:incident_report/styles/styles.dart';
import 'package:incident_report/utils/size_config.dart';

import 'package:url_launcher/url_launcher.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedTab = 0;

  List<Widget> tabs = [
    AboutUs(),
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _launchInsta() async {
    const url = 'https://www.instagram.com/tadmilmine/?hl=en';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchFacebook() async {
    const url = 'https://www.facebook.com/BullyingEndsHereCanada/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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
            return Scaffold(
              key: _scaffoldKey,
              drawer: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Color(0xff2A2626),
                ),
                child: Drawer(
                  child: ListView(
                    children: [
                      DrawerHeader(
                        child: GestureDetector(
                            onTap: () { _launchInWebViewOrVC( 'https://www.bullyingendshere.ca/clothing');
                      },
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/logo.png'),
                            ),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xff2A2626),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomListTitle(
                        'About Us',
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutUs()));
                        },
                        //  () => setState(() => _selectedTab =1),
                      ),
                      SizedBox(
                        height: 2.52 * SizeConfig.heightMultiplier,
                      ),
                      CustomListTitle(
                        'Presentation',
                        () {
                          setState(() => _selectedTab = 1);
                          _launchInWebViewOrVC(
                              'https://www.bullyingendshere.ca/presentation-outline');
                        },
                        //  () => setState(() => _selectedTab =1),
                      ),
                      SizedBox(
                        height: 2.52 * SizeConfig.heightMultiplier,
                      ),
                      CustomListTitle(
                        'Jamie Hubley',
                            () {
                          setState(() => _selectedTab = 1);
                          _launchInWebViewOrVC(
                              'https://www.bullyingendshere.ca/jamies-story');
                        },
                        //  () => setState(() => _selectedTab =1),
                      ),
                      SizedBox(
                        height: 2.52 * SizeConfig.heightMultiplier,
                      ),
                      CustomListTitle(
                        'Contests',
                            () {
                          setState(() => _selectedTab = 1);
                          _launchInWebViewOrVC(
                              'https://www.bullyingendshere.ca/contest');
                        },
                        //  () => setState(() => _selectedTab =1),
                      ),
                      SizedBox(
                        height: 2.52 * SizeConfig.heightMultiplier,
                      ),
                      CustomListTitle(
                        'Awards Nomination',
                        () {
                          setState(() => _selectedTab = 1);
                          _launchInWebViewOrVC(
                              'https://www.bullyingendshere.ca/coin-winners');
                        },
                        //  () => setState(() => _selectedTab =1),
                      ),
                      SizedBox(
                        height: 2.52 * SizeConfig.heightMultiplier,
                      ),
                      CustomListTitle(
                        'Donate Now',
                        () {
                          setState(() => _selectedTab = 1);
                          _launchInWebViewOrVC(
                              'https://www.bullyingendshere.ca/donate');
                        },
                        //  () => setState(() => _selectedTab =1),
                      ),
                    ],
                  ),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        InkWell(
                          onTap: () {
                            _scaffoldKey.currentState.openDrawer();
                          },
                          child: Icon(
                            Icons.menu,
                            size: 37,
                          ),
                        ),
                    Row(
                        children: [
                        InkWell(
                        onTap: () {
                _launchFacebook();
                },
                    child: Image.asset(
                    'assets/face.png',
                    height: 30,
                ),
              ),
                SizedBox(
                width: 10,
            ),
            InkWell(
            onTap: () {
            _launchInsta();
            },
            child: Image.asset(
            'assets/insta.png',
            height: 25,
            ),
            ),
            SizedBox(
            width: 10,
            ),
            InkWell(
            onTap: () {
            _launchInWebViewOrVC( 'https://www.bullyingendshere.ca/');
            },
            child: FaIcon(FontAwesomeIcons.globe)),
            ],
            ),
            ],
                        ),
                        HomeScreen(),
                      ],
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
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              _text,
              style: SansHeading,
            ),
          ),
        ),
      ),
    );
  }
}
