import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  String companyName = 'Thana.in.th2';

  void changeCompanyName() {
    setState(() {
      companyName = 'Thana Click2';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init state');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$companyName'),
        TextButton(
            onPressed: changeCompanyName,
            child: Text('Click Me')
        )
      ],
    );

  }
}
