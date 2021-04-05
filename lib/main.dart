import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(
    MaterialApp(
      title: "TEXT TO SPEECH",
      home: TTS(),
    ),
  );
}

class TTS extends StatefulWidget {
  @override
  _TTSState createState() => _TTSState();
}

class _TTSState extends State<TTS> {
  static final FlutterTts flutterTts = FlutterTts();
  List<dynamic> langs = [];
  List<dynamic> voices = [];
  bool gotLang = false;
  bool gotVoice = false;
  var dropDownLang;
  var selectedLang;
  TextEditingController textEditingController = new TextEditingController();
  bool isplaying = false;
  var selectedVoiceLocale;
  var dropDownVoice;
  var pitch = 100.0;
  var rate = 50.0;
  var volume = 50.0;
  // IconData playPauseIcon = Icons.play_arrow;

  @override
  void initState() {
    flutterTts.getLanguages.then((value) {
      setState(() {
        langs = value;
        gotLang = true;
      });
      print(langs);
    });

    flutterTts.getVoices.then((value) {
      setState(() {
        voices = value;
        gotVoice = true;
      });
      print(voices);
    });

    // flutterTts.setSpeechRate(rate);

    super.initState();
  }

  Future _speak() async {
    if (textEditingController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Enter text to speak",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.black,
        backgroundColor: Colors.white,
      );
    } else {
      if (selectedLang != null) {
        await flutterTts.setLanguage(selectedLang);
      }

      await flutterTts.setSpeechRate(rate / 100.0);
      await flutterTts.setPitch(pitch / 100.0);
      await flutterTts.setVolume(volume / 100.0);

      // if (selectedVoiceLocale != null) {
      //   String f;
      //   for (Map i in voices) {
      //     f = i.keys
      //         .firstWhere(
      //           (element) => i[element] == dropDownVoice,
      //         )
      //         .toString();
      //   }

      //   // Map voice = {f: dropDownVoice};
      //   await flutterTts.setVoice({f: dropDownVoice});
      //   // await flutterTts.setVoice(Map<String, String>(f, dropDownVoice.toString()));
      //   // await flutterTts.setVoice(voices[])
      // }

      await flutterTts.speak(textEditingController.text);
    }
  }

  Future _stopSpeak() async {
    // await flutterTts.pause();
    await flutterTts.stop();
  }

  String _getTime() {
    final String formattedDateTime =
        DateFormat('yyyy-MM-dd|kk:mm:ss').format(DateTime.now()).toString();
    return formattedDateTime;
  }
/*
  Future _pauseSpeak() async {
    // await flutterTts.pause();
    await flutterTts.pause();
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: SafeArea(
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Center(
              child: Text(
                "T T S",
                style: TextStyle(
                  fontSize: 30.0,
                  letterSpacing: 5.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: gotLang && gotVoice
          ? SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                  top: 20.0,
                ),
                // color: Colors.black87,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            blurRadius: 6.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      margin: EdgeInsets.all(20.0),
                      padding: EdgeInsets.only(
                        top: 5.0,
                        left: 10.0,
                        bottom: 10.0,
                        right: 10.0,
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(0.0),
                            alignment: Alignment.centerRight,
                            child: Container(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    textEditingController.clear();
                                  });
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            /*child: IconButton(
                        padding: EdgeInsets.all(0.0),
                        color: Colors.black,
                        icon: Icon(Icons.close),
                        onPressed: () {},
                      ),*/
                          ),
                          Expanded(
                            child: Container(
                              child: TextField(
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.only(
                                    left: 15,
                                    bottom: 11,
                                    top: 0,
                                    right: 15,
                                  ),
                                ),
                                maxLines: null,
                                maxLength: null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                50.0,
                              ),
                            ),
                            margin: EdgeInsets.only(
                              left: 20.0,
                              right: 10.0,
                              bottom: 20.0,
                            ),
                            padding: EdgeInsets.only(
                              top: 0.0,
                              bottom: 0.0,
                              // left: 30.0,
                              // right: 30.0,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton(
                                  hint: Text("Select Language"),
                                  iconDisabledColor: Colors.blue,
                                  value: dropDownLang,
                                  items: langs.map(
                                    (dynamic value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value.toString(),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        dropDownLang = val;
                                        selectedLang = val;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        /*
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                )
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                50.0,
                              ),
                            ),
                            margin: EdgeInsets.only(
                              left: 10.0,
                              right: 20.0,
                              bottom: 40.0,
                            ),
                            padding: EdgeInsets.only(
                              top: 0.0,
                              bottom: 0.0,
                              // left: 30.0,
                              // right: 30.0,
                            ),
                            child: DropdownButtonHideUnderline(
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton(
                                  // value: selectedVoice == null
                                  //     ? null
                                  //     : selectedVoice,
                                  value: dropDownVoice,
                                  hint: Text("Select Voice"),
                                  iconDisabledColor: Colors.blue,
                                  items: langs.map((e) {
                                    return new DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e,
                                      ),
                                    );
                                  }).toList(),

                                  /*items: voices.map(
                                    (dynamic value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                        ),
                                      );
                                    },
                                  ).toList(),*/
                                  onChanged: (val) {
                                    setState(
                                      () {
                                        dropDownVoice = val.toString();
                                        // selectedLang = val;
                                        selectedVoiceLocale = val;
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                          */
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          // padding: EdgeInsets.all(10.0),
                          icon: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 40.0,
                          ),
                          onPressed: () {
                            _speak();
                            // setState(() {
                            //   if (!isplaying) {
                            //     _speak();
                            //     playPauseIcon = Icons.pause;
                            //     isplaying = true;
                            //   } else {
                            //     _pauseSpeak();
                            //     playPauseIcon = Icons.play_arrow;
                            //     isplaying = false;
                            //   }
                            // });
                          },
                        ),
                        IconButton(
                          // padding: EdgeInsets.all(10.0),
                          icon: Icon(
                            Icons.stop,
                            color: Colors.white,
                            size: 40.0,
                          ),
                          onPressed: () {
                            _stopSpeak();
                          },
                        ),
                        /*
                        Container(
                          // width: 80.0,
                          // height: 80.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: IconButton(
                              // padding: EdgeInsets.all(10.0),
                              icon: Icon(
                                Icons.play_arrow,
                                size: 40.0,
                              ),
                              onPressed: () {
                                _speak();
                              },
                            ),
                          ),
                          // width: double.infinity,
                        ),
                        */

                        // Container(
                        //   width: 80.0,
                        //   height: 80.0,
                        //   decoration: BoxDecoration(
                        //     boxShadow: [
                        //       BoxShadow(
                        //         color: Colors.white,
                        //         blurRadius: 5.0,
                        //         spreadRadius: 1.0,
                        //       ),
                        //     ],
                        //     color: Colors.white,
                        //     shape: BoxShape.circle,
                        //   ),
                        //   // width: double.infinity
                        //   child: Center(
                        //     child: Icon(
                        //       Icons.stop,
                        //       size: 40.0,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      // color: Colors.grey[800],
                      height: 250.0,
                      padding: EdgeInsets.fromLTRB(
                        5.0,
                        10.0,
                        5.0,
                        10.0,
                      ),
                      width: double.infinity,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                            ),
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.fromLTRB(
                              10.0,
                              20.0,
                              10.0,
                              20.0,
                            ),
                            child: SleekCircularSlider(
                              min: 0,
                              max: 100,
                              initialValue: rate,
                              appearance: CircularSliderAppearance(
                                customWidths: CustomSliderWidths(
                                  progressBarWidth: 10.0,
                                ),
                                size: 200.0,
                                infoProperties: InfoProperties(
                                  topLabelText: "R A T E",
                                ),
                                customColors: CustomSliderColors(
                                  progressBarColor: Colors.black,
                                  trackColor: Colors.black54,
                                  shadowColor: Colors.black,
                                  dotColor: Colors.white,
                                ),
                              ),
                              onChange: (double value) {
                                setState(() {
                                  rate = value;
                                });
                                // print(value);
                              },
                              // innerWidget: (double val) {
                              //   return Icon(Icons.add);
                              // },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                            ),
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.fromLTRB(
                              10.0,
                              20.0,
                              10.0,
                              20.0,
                            ),
                            child: SleekCircularSlider(
                              min: 50,
                              max: 200,
                              initialValue: pitch,
                              appearance: CircularSliderAppearance(
                                customWidths: CustomSliderWidths(
                                  progressBarWidth: 10.0,
                                ),
                                size: 200.0,
                                infoProperties: InfoProperties(
                                  topLabelText: "P I T C H",
                                ),
                                customColors: CustomSliderColors(
                                  progressBarColor: Colors.black,
                                  trackColor: Colors.black54,
                                  shadowColor: Colors.black,
                                  dotColor: Colors.white,
                                ),
                              ),
                              onChange: (double value) {
                                setState(() {
                                  pitch = value;
                                });
                              },
                              // innerWidget: (double val) {
                              //   return Icon(Icons.add);
                              // },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                20.0,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                            ),
                            margin: EdgeInsets.all(10.0),
                            padding: EdgeInsets.fromLTRB(
                              10.0,
                              20.0,
                              10.0,
                              20.0,
                            ),
                            child: SleekCircularSlider(
                              min: 0,
                              max: 100,
                              initialValue: volume,
                              appearance: CircularSliderAppearance(
                                customWidths: CustomSliderWidths(
                                  progressBarWidth: 10.0,
                                ),
                                size: 200.0,
                                infoProperties: InfoProperties(
                                  topLabelText: "V O L U M E",
                                ),
                                customColors: CustomSliderColors(
                                  progressBarColor: Colors.black,
                                  trackColor: Colors.black54,
                                  shadowColor: Colors.black,
                                  dotColor: Colors.white,
                                ),
                              ),
                              onChange: (double value) {
                                setState(() {
                                  volume = value;
                                });
                              },
                              // innerWidget: (double val) {
                              //   return Icon(Icons.add);
                              // },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: <Widget>[],
                    // ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (textEditingController.text.isNotEmpty) {
                          await flutterTts.synthesizeToFile(
                              textEditingController.text,
                              _getTime() + "ttsFile.mp3");
                          Fluttertoast.showToast(
                            fontSize: 20.0,
                            msg: "SYNTHESIZING...",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            textColor: Colors.black,
                            backgroundColor: Colors.white,
                          );
                        } else {
                          Fluttertoast.showToast(
                            fontSize: 20.0,
                            msg: "Enter text to generate audio",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            textColor: Colors.black,
                            backgroundColor: Colors.white,
                          );
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              50.0,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                              ),
                            ]),
                        padding: EdgeInsets.all(10.0),
                        margin: EdgeInsets.only(
                          left: 30.0,
                          right: 30.0,
                        ),
                        child: Center(
                          child: Text(
                            "Synthesize to file",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: Container(
                height: 100.0,
                width: 100.0,
                child: SizedBox.expand(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              ),
            ),
    );
  }
}
