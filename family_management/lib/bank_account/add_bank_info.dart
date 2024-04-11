import 'package:family_management/firebase_api/add_bank_info_api.dart';
import 'package:family_management/model/bankInfo.dart';
import 'package:flutter/material.dart';

class BankInfoPage extends StatefulWidget {
  static String familyId = "";
  static String memberId = "";
  BankInfoPage({Key? key, required String familyId, required String memberId}) {
    BankInfoPage.familyId = familyId;
    BankInfoPage.memberId = memberId;
  }
  @override
  State<BankInfoPage> createState() => _BankInfoPageState();
}

class _BankInfoPageState extends State<BankInfoPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _branchNameController = TextEditingController();
  TextEditingController _ifscCodeController = TextEditingController();
  TextEditingController _ownerNameController = TextEditingController();
  TextEditingController _accountNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  String? _selectedAccountType;
  List<String> _accountTypes = [
    'Savings Account',
    'Current Account',
    'Salary Account',
    'NRI Account',
    'Recurring Deposit Account',
    'Fixed Deposit Account'
  ];

  List<BankInfo> _bankInfoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Information'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _bankNameController,
                decoration: InputDecoration(labelText: 'Bank Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter bank name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _branchNameController,
                decoration: InputDecoration(labelText: 'Branch Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter branch name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ifscCodeController,
                decoration: InputDecoration(labelText: 'IFSC Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter IFSC code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ownerNameController,
                decoration: InputDecoration(labelText: 'Owner Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter owner name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _accountNameController,
                decoration: InputDecoration(labelText: 'Account Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter account name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  // Simple email validation
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  // Simple phone number validation
                  if (value.length != 10) {
                    return 'Phone number must be 10 digits';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedAccountType,
                items: _accountTypes.map((String type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedAccountType = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Account Type'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select account type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    addBankInfo();
                  }
                },
                child: Text('Add Bank Information'),
              ),
              SizedBox(height: 20.0),
              _bankInfoList.isEmpty
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Bank Information List',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10.0),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: _bankInfoList.length,
                          itemBuilder: (context, index) {
                            var bankInfo = _bankInfoList[index];
                            return Card(
                              child: ListTile(
                                title: Text('Bank Name: ${bankInfo.bankName}'),
                                subtitle: Text(
                                    'Branch Name: ${bankInfo.branchName}\n'
                                    'IFSC Code: ${bankInfo.ifscCode}\n'
                                    'Owner Name: ${bankInfo.ownerName}\n'
                                    'Account Name: ${bankInfo.accountName}\n'
                                    'Email: ${bankInfo.email}\n'
                                    'Phone Number: ${bankInfo.phoneNumber}\n'
                                    'Account Type: ${bankInfo.accountType}'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void addBankInfo() async {
    if (_formKey.currentState!.validate()) {
      var response = await BankInfoService.addBankInfo(
        bankName: _bankNameController.text.trim(),
        branchName: _branchNameController.text.trim(),
        ifscCode: _ifscCodeController.text.trim(),
        ownerName: _ownerNameController.text.trim(),
        accountName: _accountNameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _phoneNumberController.text.trim(),
        accountType: _selectedAccountType!,
        familyId: BankInfoPage.familyId,
        memberId: BankInfoPage.memberId,
      );

      if (response.code != 200) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(response.message.toString()),
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bank information added successfully')),
        );
      }
    }
  }

  void _clearTextFields() {
    _bankNameController.clear();
    _branchNameController.clear();
    _ifscCodeController.clear();
    _ownerNameController.clear();
    _accountNameController.clear();
    _emailController.clear();
    _phoneNumberController.clear();
    _selectedAccountType = null;
  }
}
