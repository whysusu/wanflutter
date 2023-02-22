import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProviderWidget<A extends ChangeNotifier, B extends ChangeNotifier>
    extends StatefulWidget {
  @override
  _ProviderWidgetState<A, B> createState() {
    return _ProviderWidgetState<A, B>();
  }

  ProviderWidget(
      {Key key,
      @required this.builder,
      @required this.model1,
      @required this.model2,
      this.child,
      this.onModelReady})
      : super(key: key);

  final Widget Function(BuildContext context, A modelA, B modelB, Widget child)
      builder;

  final A model1;
  final B model2;
  final Widget child;
  final Function(A, B) onModelReady;
}

class _ProviderWidgetState<A extends ChangeNotifier, B extends ChangeNotifier>
    extends State<ProviderWidget<A, B>> {
  A modelA;
  B modelB;

  @override
  void initState() {
    modelA = widget.model1;
    modelB = widget.model2;
    if (widget.onModelReady != null) {
      widget.onModelReady(modelA, modelB);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<A>(
          create: (context) => modelA,
        ),
        ChangeNotifierProvider<B>(
          create: (context) => modelB,
        )
      ],
      child: Consumer2<A, B>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}

class ProviderWidgetOne<T extends ChangeNotifier> extends StatefulWidget {
  @override
  _ProviderWidgetOneState<T> createState() {
    return _ProviderWidgetOneState<T>();
  }

  ProviderWidgetOne(
      {Key key,
      @required this.build,
      @required this.modelT,
      this.child,
      this.onModelReady})
      : super(key: key);

  final Widget Function(BuildContext context, T modelT, Widget child) build;
  final T modelT;
  final Widget child;
  final Function(T) onModelReady;
}

class _ProviderWidgetOneState<T extends ChangeNotifier>
    extends State<ProviderWidgetOne<T>> {
  T model;

  @override
  void initState() {
    model = widget.modelT;
    if (widget.onModelReady != null) {
      widget.onModelReady(model);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<T>(
          create: (context) => model,
        ),
      ],
      child: Consumer<T>(
        builder: widget.build,
        child: widget.child,
      ),
    );
  }
}
