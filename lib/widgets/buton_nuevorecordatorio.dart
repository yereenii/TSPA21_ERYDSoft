import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:diabits/utils/responsive.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

class Button extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    _summit() {
      Navigator.pushNamed(context, 'nuevorecordatorio');
    }

    final Responsive responsive = Responsive.of(context);
    return Container(
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Text(
          'Nuevo Recordatorio',
          style: TextStyle(
            color: Colors.white,
            fontSize: responsive.dp(2),
          ),
        ),
        onPressed: _summit,
        color: Colors.blue.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
