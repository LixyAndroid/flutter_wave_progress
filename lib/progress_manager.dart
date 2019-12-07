/**
 *@author Li Xuyang
 *@date : 2019/10/21 20:21
 */

import 'package:flutter/material.dart';
import 'package:flutter_wave_progress/wave_painter_factory.dart';


class ProgressManager extends StatefulWidget {
  @override
  _ProgressManagerState createState() =>
      new _ProgressManagerState().._factory = WavePainterFactory();
}

class _ProgressManagerState extends State<ProgressManager>
    with TickerProviderStateMixin {
  AnimationController xController;
  AnimationController yController;
  Animation<double> xAnimation;
  Animation<double> yAnimation;
  List<double> _progressList = [];

  double beProgress = 0.00;
  double curProgress = 0.66;

  BasePainterFactory _factory;

  set painter(BasePainterFactory factory) {
    _factory = factory;
  }

  setProgress(double progress) {
    _progressList.add(progress);
    onProgressChange();
  }

  onProgressChange() {
    if (_progressList.length > 0) {
      if (yController != null && yController.isAnimating) {
        return;
      }
      double nextProgress = _progressList[0];
      _progressList.removeAt(0);
      final double begin = beProgress;
      yController = new AnimationController(
          vsync: this, duration: Duration(milliseconds: 2000));
      yAnimation =
          new Tween(begin: begin, end: nextProgress).animate(yController);
      yAnimation.addListener(_onProgressChange);
      yAnimation.addStatusListener(_onProgressStatusChange);
      yController.forward();
    }
  }

  @override
  void initState() {
    super.initState();
    xController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    xAnimation = new Tween(begin: 0.0, end: 1.0).animate(xController);
    xAnimation.addListener(_change);
    yController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    yAnimation = new Tween(begin: 0.0, end: 1.0).animate(yController);
    yAnimation.addListener(_onProgressChange);
    yAnimation.addStatusListener(_onProgressStatusChange);

    doDelay(xController, 0);

    doDelay(xController, 0);

    Future.delayed(Duration(milliseconds: 1000), () {
      setProgress(curProgress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child:  Stack(
          alignment: Alignment(0.0,0.8),
          children: <Widget>[


            CustomPaint(
              painter: _factory.getPainter()
                ..XAnimation = xAnimation
                ..YAnimation = yAnimation,
              size: new Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.width),
            ),
            Image.asset('images/bubble.png'),

          ],
        )

    );
  }

  void _change() {

    if(mounted){
      setState(() {});
    }

  }

  void _onProgressChange() {


    if(mounted){
      setState(() {
        beProgress = yAnimation.value;
      });
    }

  }

  void _onProgressStatusChange(status) {
    if (status == AnimationStatus.completed) {
      onProgressChange();
    }
  }

  void doDelay(AnimationController controller, int delay) async {
    Future.delayed(Duration(milliseconds: delay), () {
      controller..repeat();
    });
  }

  @override
  void dispose() {
    xController.dispose();
    yController.dispose();
    xAnimation.removeListener(_change);
    yAnimation.removeListener(_onProgressChange);
    yAnimation.removeStatusListener(_onProgressStatusChange);
    super.dispose();
  }
}
