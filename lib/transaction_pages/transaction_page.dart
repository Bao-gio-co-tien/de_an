import 'package:de_an/models/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'categories_service.dart';
import '../models/nav_bar.dart';
import 'category.dart';
import 'transactions.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String? _selectedCategoryId;
  final CategoriesService _categoriesService = CategoriesService();
  String _selectedType = 'Chi tiêu';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm giao dịch', style: AppTheme.heading2),
        backgroundColor: AppTheme.primaryBackgroundColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => NavBar()),
              icon: Icon(Icons.clear)
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          color: AppTheme.primaryBackgroundColor,
          padding: AppTheme.allPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedType == 'Chi tiêu'
                              ? Colors.red[400]
                              : Colors.grey[300],
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedType = 'Chi tiêu';
                            _selectedCategoryId = null;
                          });
                        },
                        child: Text(
                          'Chi tiêu',
                          style: TextStyle(
                            color: _selectedType == 'Chi tiêu'
                                ? Colors.white
                                : Colors.black,
                            fontFamily: AppTheme.fontFamily,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _selectedType == 'Thu nhập'
                              ? Colors.green[400]
                              : Colors.grey[300],
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedType = 'Thu nhập';
                            _selectedCategoryId = null;
                          });
                        },
                        child: Text(
                          'Thu nhập',
                          style: TextStyle(
                            color: _selectedType == 'Thu nhập'
                                ? Colors.white
                                : Colors.black,
                            fontFamily: AppTheme.fontFamily,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Category Dropdown with filtered categories
                StreamBuilder<List<Category>>(
                  stream: _categoriesService.getCategories(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Lỗi: ${snapshot.error}');
                    }

                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }

                    List<Category> categories = snapshot.data!
                        .where((category) => category.type == _selectedType)
                        .toList();

                    if (categories.isEmpty) {
                      return Text('Không có mục lục ${_selectedType}');
                    }

                    return DropdownButtonFormField<String>(
                      value: _selectedCategoryId,
                      decoration: InputDecoration(
                        labelText: 'Mục lục',
                        border: OutlineInputBorder(),
                      ),
                      items: categories.map((category) {
                        return DropdownMenuItem(
                          value: category.id,
                          child: Row(
                            children: [
                              if (category.icon != null)
                                Icon(
                                  category.getIcon(),
                                  color: _selectedType == 'Thu nhập'
                                      ? Colors.green
                                      : Colors.red,
                                  size: 24,
                                ),
                              SizedBox(width: 12),
                              Text(category.name, style: AppTheme.heading5,),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategoryId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Hãy chọn mục lục';
                        }
                        return null;
                      },
                    );
                  },
                ),
                SizedBox(height: 16),

                // Amount Field
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Số tiền',
                    border: OutlineInputBorder(),
                    prefixText: 'VND ',
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: _selectedType == 'Thu nhập'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Hãy nhập khoản tiền';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Hãy nhập số';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Note Field
                TextFormField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    labelText: 'Ghi chú (Tùy chọn)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.note),
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitTransaction,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedType == 'Thu nhập'
                          ? Colors.green[400]
                          : Colors.red[400],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: Text(
                      'Thêm giao dịch',
                      style: AppTheme.heading3.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submitTransaction() async {
    if (_formKey.currentState!.validate()) {
      try {
        final transaction = Transactions(
          id: '',
          amount: _selectedType == 'Chi tiêu'
              ? -double.parse(_amountController.text)
              : double.parse(_amountController.text),
          categoryId: _selectedCategoryId!,
          date: DateTime.now(),
          note: _noteController.text.isEmpty ? null : _noteController.text,
          type: _selectedType,
        );

        await _categoriesService.addTransaction(transaction);

        _amountController.clear();
        _noteController.clear();
        setState(() {
          _selectedCategoryId = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Giao dịch ${_selectedType.capitalize} thêm thành công'),
            backgroundColor: _selectedType == 'Thu nhập' ? Colors.green : Colors.red,
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi thêm giao dịch: $e')),
        );
      }
    }
  }


  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}

