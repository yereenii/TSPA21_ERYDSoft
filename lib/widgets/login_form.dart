import 'package:diabits/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Input_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    return Positioned(
      bottom: 30,
      child: Container(
        constraints: BoxConstraints(
          //ancho del dispositivo si es tablet 430 si no ancho-30
          maxWidth: responsive.isTablet ? 430 : responsive.width - 30,
        ),
        child: Column(
          children: <Widget>[
            InputText(
              keyboardType: TextInputType.emailAddress,
              fontSize: responsive.dp(responsive.isTablet ? 1.7 : 1.4),
              label: 'E-MAIL ADDRESS',
            ),
            SizedBox(height: responsive.dp(2)),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black12,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InputText(
                      obscureText: true,
                      borderEnabled: false,
                      fontSize: responsive.dp(responsive.isTablet ? 1.7 : 1.4),
                      label: 'PASSWORD',
                    ),
                  ),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    onPressed: () {},
                    child: Text(
                      'Forgot Password',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize:
                            responsive.dp(responsive.isTablet ? 1.7 : 1.4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: responsive.dp(5)),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsive.dp(1.5),
                  ),
                ),
                onPressed: () {},
                color: Colors.blue[700],
              ),
            ),
            SizedBox(height: responsive.dp(2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Nuevo usuario?',
                  style: TextStyle(fontSize: responsive.dp(1.5)),
                ),
                MaterialButton(
                  onPressed: () {},
                  child: Text(
                    'Sign UP',
                    style: TextStyle(
                        color: Colors.blueAccent, fontSize: responsive.dp(1.5)),
                  ),
                ),
              ],
            ),
            SizedBox(height: responsive.dp(8)),
          ],
        ),
      ),
    );
  }
}
