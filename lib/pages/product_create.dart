import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  final Function addProduct;

  ProductCreatePage(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  String _titleValue = '';
  String _descriptionValue = '';
  double _priceValue;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product Title',
      ),
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should be more then 5 characters!!';
        }
      },
      onSaved: (String value) {
        setState(() {
          _titleValue = value;
        });
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product Description',
      ),
      maxLines: 4,
      onSaved: (String value) {
        setState(() {
          _descriptionValue = value;
        });
      },
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'Description is required and should be more then 10 characters!!';
        }
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Product Price',
      ),
      keyboardType: TextInputType.number,
      onSaved: (String value) {
        setState(() {
          _priceValue = double.parse(value);
        });
      },
      validator: (String value) {
        if (double.tryParse(value) == null || double.parse(value) <= 0) {
          return 'Price is required and should be a number!!';
        }
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final Map<String, dynamic> product = {
      'title': _titleValue,
      'description': _descriptionValue,
      'price': _priceValue,
      'image': 'assets/food.jpg'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/products');
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    final double targetPadding = deviceWidth - targetWidth;

    return Container(
      margin: EdgeInsets.all(10.0),
      child: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: targetPadding / 2),
          children: <Widget>[
            _buildTitleTextField(),
            _buildDescriptionTextField(),
            _buildPriceTextField(),
            SizedBox(height: 10.0),
            RaisedButton(
              child: Text('Saved'),
              color: Theme.of(context).accentColor,
              textColor: Colors.white,
              onPressed: _submitForm,
            ),
            Container(
              color: Colors.green,
            )
          ],
        ),
      ),
    );
  }
}
