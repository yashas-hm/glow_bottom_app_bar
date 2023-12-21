import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class GlowBottomAppBar extends StatefulWidget {
  const GlowBottomAppBar({
    super.key,
    required this.onChange,
    required this.children,
    required this.selectedChildren,
    this.height = 60.0,
    this.iconSize = 40.0,
    this.duration = const Duration(milliseconds: 1000),
    this.glowColor = Colors.blueAccent,
    this.shadowColor = Colors.black26,
    this.background,
    this.width,
  });

  final List<Widget> children;

  final List<Widget> selectedChildren;

  final Function(int) onChange;

  final double height;

  final double? width;

  final double iconSize;

  final Duration duration;

  final Color glowColor;

  final Color? background;

  final Color shadowColor;

  @override
  State<GlowBottomAppBar> createState() => _GlowBottomAppBarState();
}

class _GlowBottomAppBarState extends State<GlowBottomAppBar>
    with SingleTickerProviderStateMixin {
  final Map<GlobalKey, Widget> list = {};
  final List<GlobalKey> keys = [];
  int oldIndex = 0;
  double? from;
  double? to;
  late Animation<double> scaleAnim;
  late Animation<double> slideAnim;
  late AnimationController animationController;
  Color? background;
  double? width;
  double? margin;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    generateKeys();
    buildChildren();

    background = widget.background;
    width = widget.width;

    animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    scaleAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1), weight: 0.5),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1), weight: 0.5),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1), weight: 0.5),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0.5), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0.5, end: 1), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1), weight: 0.5),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 1), weight: 0.5),
      TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0), weight: 0.5),
    ]).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.linear,
      ),
    );

    createSlideAnim(0, 0);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          from = to!;
          to = null;
          buildChildren();
          createSlideAnim(from!, 0);
        });
        animationController.reset();
      }
    });

    super.initState();
  }

  void createSlideAnim(
    double begin,
    double end,
  ) {
    slideAnim = Tween<double>(
      begin: begin,
      end: end,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0.375,
          0.625,
          curve: Curves.linear,
        ),
      ),
    );
  }

  double getXOffset(index) {
    final GlobalKey iconKey = list.keys.toList()[index];
    RenderBox box = iconKey.currentContext?.findRenderObject() as RenderBox;
    Offset offset = box.localToGlobal(Offset.zero);
    return offset.dx - margin!;
  }

  void startAnimation(int index) {
    if (index != oldIndex) {
      setState(() {
        to = getXOffset(index);
        createSlideAnim(from!, to!);
        oldIndex = -1;
        buildChildren();
      });
      oldIndex = index;
      animationController.forward();
      widget.onChange(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    background ??= Theme.of(context).scaffoldBackgroundColor;
    width ??= screenSize.width / 1.3;
    margin ??= (screenSize.width - width!) / 2;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (from == null) {
        setState(() {
          from = getXOffset(0);
          createSlideAnim(from!, 0);
        });
      }
    });

    return Container(
      height: widget.height,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.only(
        bottom: 20,
        right: margin!,
        left: margin!,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(widget.height / 2),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: widget.shadowColor,
          ),
        ],
      ),
      child: Stack(
        children: [
          AnimatedBuilder(
              animation: animationController,
              builder: (context, _) {
                return Container(
                  transform: Matrix4.translationValues(
                    slideAnim.value,
                    ((widget.height / 2) - (widget.iconSize / 2)),
                    0,
                  ),
                  height: widget.iconSize,
                  width: widget.iconSize,
                  alignment: Alignment.center,
                  child: Container(
                    height: 1,
                    width: 1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.glowColor,
                      boxShadow: [
                        BoxShadow(
                          color: widget.glowColor,
                          blurRadius: widget.iconSize * 1.5 * scaleAnim.value,
                          spreadRadius: widget.iconSize * 1.5 * scaleAnim.value,
                        ),
                      ],
                    ),
                  ),
                );
              }),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: getChildren(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getChildren() {
    final List<Widget> widgets = [];
    for (var i in list.keys) {
      widgets.add(list[i]!);
    }
    return widgets;
  }

  void generateKeys() {
    for (var index = 0; index < widget.children.length; index++) {
      final key = GlobalKey();
      keys.add(key);
    }
  }

  void buildChildren() {
    list.clear();
    for (var index = 0; index < widget.children.length; index++) {
      list[keys[index]] = GestureDetector(
        onTap: () => startAnimation(index),
        child: SizedBox(
          key: keys[index],
          height: widget.iconSize,
          width: widget.iconSize,
          child: oldIndex == index
              ? widget.selectedChildren[index]
              : widget.children[index],
        ),
      );
    }
  }
}
