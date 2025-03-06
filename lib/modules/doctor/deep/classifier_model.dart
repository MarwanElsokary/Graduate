// import 'package:tflite_flutter/tflite_flutter.dart';
class ClassifierCategory {
  final String label;
  final double score;

  ClassifierCategory(this.label, this.score);

  @override
  String toString() {
    return 'Category{label: $label, score: $score}';
  }
}

class ClassifierModel {
  // Interpreter interpreter;
  List<int> inputShape;
  List<int> outputShape;

  // TfLiteType inputType;
  // TfLiteType outputType;

  ClassifierModel({
    // required this.interpreter,
    required this.inputShape,
    required this.outputShape,
    // required this.inputType,
    // required this.outputType,
  });
}
