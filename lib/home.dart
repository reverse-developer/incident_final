import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:incident_report/screens/form.dart';
import 'package:incident_report/styles/styles.dart';
import 'package:incident_report/utils/size_config.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  _launchVideo() async {
    const url = 'https://www.youtube.com/watch?v=_KPKBtg3vFE';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchURL() async {
    const url = 'https://www.bullyingendshere.ca/';
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
    return Column(
      children: [
        Padding(
          padding:
          EdgeInsets.symmetric(vertical: 1.4 * SizeConfig.heightMultiplier),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/full.png',
                  height: 8.04 * SizeConfig.heightMultiplier,
                ),
                SizedBox(
                  height: 1.2 * SizeConfig.heightMultiplier,
                ),
                Stack(
                  children: [
                    Container(
                      height: 19.98 * SizeConfig.heightMultiplier,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/video.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 1.4 * SizeConfig.heightMultiplier,
                      right: 2.4 * SizeConfig.widthMultiplier,
                      child: GestureDetector(
                        onTap: () async {
                          _launchVideo();
                        },
                        child: Container(
                          width: 26.66 * SizeConfig.widthMultiplier,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: 3.78 * SizeConfig.heightMultiplier,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Play',
                                style: SansHeading,
                              ),
                              Icon(
                                Icons.arrow_forward,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 20.98 * SizeConfig.heightMultiplier,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Container(
                            height: 7.49 * SizeConfig.heightMultiplier,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color(0xff2A2626),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 15.49 * SizeConfig.heightMultiplier,
                            width: 80 * SizeConfig.widthMultiplier,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 15,
                                      offset: Offset(0, 3))
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 53.33 * SizeConfig.widthMultiplier,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Report an Incident!',
                                          style: SansHeading,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'We are here to help you. Please report the incident here.',
                                          softWrap: true,
                                          maxLines: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReportForm(),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff2A2626),
                                    child: Icon(
                                      Icons.arrow_forward,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 20.98 * SizeConfig.heightMultiplier,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18.0),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Color(0xff2A2626),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 15.49 * SizeConfig.heightMultiplier,
                            width: 80 * SizeConfig.widthMultiplier,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 15,
                                      offset: Offset(0, 3))
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  width: 53.33 * SizeConfig.widthMultiplier,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Other Resources!!',
                                          style: SansHeading,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'View other resources on our website',
                                          softWrap: true,
                                          maxLines: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    _launchInWebViewOrVC(
                                        'https://www.bullyingendshere.ca/resources');
                                  },
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff2A2626),
                                    child: Icon(
                                      Icons.arrow_forward,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Image.asset(
                  'assets/half.png',
                  width: 46.68 * SizeConfig.imageSizeMultiplier,
                ),
              ],
            ),
          ),
        ),
      ],
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
