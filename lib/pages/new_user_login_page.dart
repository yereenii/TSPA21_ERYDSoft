import 'package:diabits/utils/responsive.dart';
import 'package:diabits/widgets/circles.dart';
import 'package:diabits/widgets/new_user_login_form.dart';
import 'package:flutter/material.dart';

class NewUserLoginPage extends StatefulWidget {
  static const routeName = 'nuevousuario';
  //const NewUserLoginPage({ Key? key }) : super(key: key);

  @override
  _NewUserLoginPageState createState() => _NewUserLoginPageState();
}

class _NewUserLoginPageState extends State<NewUserLoginPage> {
  final String _titlepage = 'Nuevo usuario';

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_titlepage),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            width: responsive.width,
            height: responsive.height,
            color: Colors.white,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                NewUserLoginForm(),
                Positioned(
                  top: responsive.wp(-20),
                  child: const Circles(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
