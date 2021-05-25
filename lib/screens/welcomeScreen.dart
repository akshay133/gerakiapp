import 'package:flutter/material.dart';
import 'package:geraki/constants/colors.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Welcome()
    );
  }
}

class Welcome extends StatelessWidget {
  const Welcome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: Container(
                color: primaryColor,
                child: Center(child: Text('Body Icon'),),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){},
                      child: Container(
                        width: MediaQuery.of(context).size.width-60,
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 9, 20, 9),
                          child: Center(
                            child: Text('SIGN UP',
                              style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        width: MediaQuery.of(context).size.width-60,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 9, 20, 9),
                          child: Center(
                            child: Text('LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: (){},
                        child: Text('CONTINUE AS GUEST',
                          style: TextStyle(
                              color: primaryColor
                          ),))
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}
