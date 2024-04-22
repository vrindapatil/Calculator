import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:calculator/ButtonValue.dart';
import 'package:dart_eval/dart_eval.dart';
import 'package:math_expressions/math_expressions.dart';

import 'HomeEvent.dart';
import 'HomeState.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeNumPadButtonClickEvent>(homeNumPadButtonClickEvent);
  }

  FutureOr<void> homeNumPadButtonClickEvent(
      HomeNumPadButtonClickEvent event, Emitter<HomeState> emit) {
    if (event.value == ButtonAction.ALLCLEAR) {
      inputString = "";
      resultString = "";
    } else if (event.value == ButtonAction.DELETE) {
      if (inputString != "") {
        inputString = inputString.substring(0, inputString.length - 1);

        if (inputString == "") {
          resultString = "";
        } else {
          var lastChar =
              inputString.substring(inputString.length - 1, inputString.length);
          if (lastChar != ButtonValue.ADDITION &&
              lastChar != ButtonValue.DIVISION &&
              lastChar != ButtonValue.MULTIPLICATION &&
              lastChar != ButtonValue.SUBTRACTION &&
              lastChar != ButtonValue.PERSENTAGE) {
            try {
              Parser p = Parser();
              Expression exp = p.parse(inputString);
              ContextModel cm = ContextModel();
              double eval = exp.evaluate(EvaluationType.REAL, cm);
              resultString = eval.toString();
            } catch (e) {
              resultString = "Error";
            }
          }
        }
      }
    } else if (event.value == ButtonAction.INVERT) {
      if (inputString[0] == "-") {
        inputString = inputString.substring(1, inputString.length);
      } else {
        inputString = "-" + inputString;
      }
      var lastChar =
          inputString.substring(inputString.length - 1, inputString.length);
      if (lastChar != ButtonValue.ADDITION &&
          lastChar != ButtonValue.DIVISION &&
          lastChar != ButtonValue.MULTIPLICATION &&
          lastChar != ButtonValue.SUBTRACTION &&
          lastChar != ButtonValue.PERSENTAGE) {
        try {
          Parser p = Parser();
          Expression exp = p.parse(inputString);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);
          resultString = eval.toString();
        } catch (e) {
          resultString = "Error";
        }
      }
    } else if (event.value == ButtonAction.EQUALTO) {
      try {
        Parser p = Parser();
        Expression exp = p.parse(inputString);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        inputString = eval.toString();
        resultString = "";
      } catch (e) {
        resultString = "Error";
      }
      // inputString = eval(inputString).toString();
    } else {
      if ((inputString.length >= 15 &&
          (inputString.substring(inputString.length - 15, inputString.length)
              .contains(ButtonValue.DIVISION) ||
              inputString.substring(inputString.length - 15, inputString.length)
                  .contains(ButtonValue.MULTIPLICATION) ||
              inputString.substring(inputString.length - 15, inputString.length)
                  .contains(ButtonValue.ADDITION) ||
              inputString.substring(inputString.length - 15, inputString.length)
                  .contains(ButtonValue.SUBTRACTION) ||
              inputString.substring(inputString.length - 15, inputString.length)
                  .contains(ButtonValue.PERSENTAGE))) ||
          inputString.length < 15 ||
          event.value == ButtonValue.ADDITION ||
          event.value == ButtonValue.DIVISION ||
          event.value == ButtonValue.MULTIPLICATION ||
          event.value == ButtonValue.SUBTRACTION ||
          event.value == ButtonValue.PERSENTAGE) {
        var lastChar;
        if (inputString != "") {
          lastChar =
              inputString.substring(inputString.length - 1, inputString.length);
        }
        if ((lastChar == ButtonValue.ADDITION ||
            lastChar == ButtonValue.DIVISION ||
            lastChar == ButtonValue.MULTIPLICATION ||
            lastChar == ButtonValue.SUBTRACTION ||
            lastChar == ButtonValue.PERSENTAGE) &&
            (event.value == ButtonValue.ADDITION ||
                event.value == ButtonValue.DIVISION ||
                event.value == ButtonValue.MULTIPLICATION ||
                event.value == ButtonValue.SUBTRACTION ||
                event.value == ButtonValue.PERSENTAGE)) {
          inputString = inputString.substring(0, inputString.length - 1) +
              event.value.toString();
        } else {
          if (event.value != ButtonValue.DOTE ||
              inputString.contains(ButtonValue.DOTE)) {
            inputString += event.value.toString();
          }
        }

        lastChar =
            inputString.substring(inputString.length - 1, inputString.length);
        if (lastChar != ButtonValue.ADDITION &&
            lastChar != ButtonValue.DIVISION &&
            lastChar != ButtonValue.MULTIPLICATION &&
            lastChar != ButtonValue.SUBTRACTION &&
            lastChar != ButtonValue.PERSENTAGE) {
          try {
            Parser p = Parser();
            Expression exp = p.parse(inputString);
            ContextModel cm = ContextModel();
            double eval = exp.evaluate(EvaluationType.REAL, cm);
            resultString = eval.toString();
          } catch (e) {
            resultString = "Error";
          }
        }
      }
    }

    emit(HomeUpdateInputStringState());
  }
}
