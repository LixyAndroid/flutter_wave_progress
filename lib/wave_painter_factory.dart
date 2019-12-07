/**
 *@author Li Xuyang
 *@date : 2019/10/21 20:20
 */

import 'package:flutter/material.dart';
import 'package:flutter_wave_progress/wave_painter.dart';


import 'base_painter.dart';


abstract class BasePainterFactory {
  BasePainter getPainter();
}

class WavePainterFactory extends BasePainterFactory {
  BasePainter getPainter() {
    return WavePainter(
      waveCount: 2,
      waveColors: [
        Color(0x4099EFFF),
        Color(0xff99EFFF),
      ],
      crestCount: 2,

      textStyle: TextStyle(
        fontSize: 60.0,
        foreground: Paint()
          ..color = Colors.lightBlue
          ..style = PaintingStyle.fill
          ..strokeWidth = 2.0
          ..blendMode = BlendMode.difference
          ..colorFilter = ColorFilter.mode(Colors.white, BlendMode.exclusion)
          ..maskFilter = MaskFilter.blur(BlurStyle.solid, 1.0),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
