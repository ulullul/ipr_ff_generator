import 'package:analyzer/dart/element/element.dart';

typedef Getters = ({String abstractGetter, String implementationGetter});

abstract interface class GetterBuilder {
  final EnumElement enumElement;

  const GetterBuilder({required this.enumElement});

  Iterable<Getters> build();
}
