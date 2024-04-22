import 'package:calculator/Bloc/HomeBloc.dart';
import 'package:calculator/Bloc/HomeEvent.dart';
import 'package:calculator/Bloc/HomeState.dart';
import 'package:calculator/ButtonValue.dart';
import 'package:calculator/UI/CustomScroll.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rich_text_controller/rich_text_controller.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}



class _HomeState extends State<Home> {
  final inputStringController = RichTextController(
    patternMatchMap: {
      RegExp(
        "0|1|2|3|4|5|6|7|8|9|./g",
      ): TextStyle(color: Colors.white),
    },
    onMatch: (List<String> matches) {},
  );

  @override
  void initState() {
    // TODO: implement initState
    inputStringController!.text = inputString;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    numPadIconButton(icon, bgColor, textColor, value) {
      return Container(
        margin: EdgeInsets.all(10),
        child: InkWell(
          onTap: (){
            context.read<HomeBloc>().add(HomeNumPadButtonClickEvent(value: value));
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: bgColor),
            child: Center(
                child: Icon(
                  icon,
                  color: textColor,
                )),
          ),
        ),
      );
    }

    numPadButton(text, bgColor, textColor, value) {
      return Container(
        margin: EdgeInsets.all(10),
        child: InkWell(
          onTap: (){
            context.read<HomeBloc>().add(HomeNumPadButtonClickEvent(value: value));
          },
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: bgColor),
            child: Center(
              child: Text(
                text.toString(),
                style: TextStyle(color: textColor, fontSize: 27),
              ),
            ),
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.black,
                child: Center(
                  child: BlocConsumer<HomeBloc, HomeState>(
                    buildWhen: (previous, current) => current is HomeState,
                    listener: (context, state) {},
                    builder: (context, state) {
                      inputStringController.text = inputString.replaceAll("*", "×").replaceAll("/", "÷");
                      return SizedBox(
                        height: 120,
                        child: Padding(
                          padding : EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              TextFormField(
                                showCursor: true,
                                readOnly: true,
                                controller: inputStringController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  border:InputBorder.none,
                                  fillColor: Colors.black,
                                  filled: true
                                ),
                                style: TextStyle(
                                  fontSize:50,
                                  color: Colors.orange
                                ),
                                textAlign: TextAlign.end,
                              ),
                              Text(
                                  resultString,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 32
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: 497,
              color: Colors.black,
              child: ScrollConfiguration(
                behavior: CustomScroll(),
                child: GridView.count(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  crossAxisCount: 4,
                  children: [
                    numPadButton("AC", Colors.orange, Colors.white, ButtonAction.ALLCLEAR),
                    numPadIconButton(CupertinoIcons.delete_left,
                        Colors.orange.withOpacity(0.3), Colors.orange, ButtonAction.DELETE),
                    numPadButton(
                        "+\/-", Colors.orange.withOpacity(0.3), Colors.orange, ButtonAction.INVERT),
                    numPadIconButton(CupertinoIcons.divide,
                        Colors.orange.withOpacity(0.3), Colors.orange, ButtonValue.DIVISION),
                    numPadButton(
                        ButtonValue.SEVEN, Color(0xFF3D3D3D), Colors.white,ButtonValue.SEVEN),
                    numPadButton(
                        ButtonValue.EIGHT, Color(0xFF3D3D3D), Colors.white,ButtonValue.EIGHT),
                    numPadButton(
                        ButtonValue.NINE, Color(0xFF3D3D3D), Colors.white, ButtonValue.NINE),
                    numPadIconButton(CupertinoIcons.multiply,
                        Colors.orange.withOpacity(0.3), Colors.orange, ButtonValue.MULTIPLICATION),
                    numPadButton(
                        ButtonValue.FOUR, Color(0xFF3D3D3D), Colors.white, ButtonValue.FOUR),
                    numPadButton(
                        ButtonValue.FIVE, Color(0xFF3D3D3D), Colors.white, ButtonValue.FIVE),
                    numPadButton(
                        ButtonValue.SIX, Color(0xFF3D3D3D), Colors.white, ButtonValue.SIX),
                    numPadIconButton(CupertinoIcons.minus,
                        Colors.orange.withOpacity(0.3), Colors.orange, ButtonValue.SUBTRACTION),
                    numPadButton(
                        ButtonValue.ONE, Color(0xFF3D3D3D), Colors.white, ButtonValue.ONE),
                    numPadButton(
                        ButtonValue.TWO, Color(0xFF3D3D3D), Colors.white, ButtonValue.TWO),
                    numPadButton(
                        ButtonValue.THREE, Color(0xFF3D3D3D), Colors.white, ButtonValue.THREE),
                    numPadIconButton(CupertinoIcons.add,
                        Colors.orange.withOpacity(0.3), Colors.orange, ButtonValue.ADDITION),
                    numPadIconButton(
                        CupertinoIcons.percent, Color(0xFF3D3D3D), Colors.orange, ButtonValue.PERSENTAGE),
                    numPadButton(
                        ButtonValue.ZERO, Color(0xFF3D3D3D), Colors.white,ButtonValue.ZERO),
                    numPadButton(
                      ".",
                      Color(0xFF3D3D3D),
                      Colors.orange,
                        ButtonValue.DOTE
                    ),
                    numPadIconButton(
                        CupertinoIcons.equal, Colors.orange, Colors.white, ButtonAction.EQUALTO),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
