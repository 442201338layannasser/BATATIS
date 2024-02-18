import 'package:batatis/Costomer_Screens/Costomer_SignIn.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '/Customer_Widgets/All_customer_Widgets.dart';
import 'package:batatis/provider/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CSettings extends StatefulWidget {
  const CSettings({super.key});

  @override
  State<CSettings> createState() => CSettingsState();
}

class CSettingsState extends State<CSettings> {
  TextEditingController _nameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    String errormassages;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Customers')
                  .doc(SharedPrefer.UserId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                var data = snapshot.data!.data() as Map<String, dynamic>?;

                if (data == null) {
                  return Text('No data available'); // or some other fallback
                }

                String name = data['name'] as String? ?? '';
                String phoneNumber = data['phonenumber'] as String? ?? '';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My account',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 8),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _showEditNameDialog();
                            },
                            child: TextField(
                              controller: TextEditingController(text: name),
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        IconButton(
                          icon: Icon(Icons.edit, size: 20),
                          onPressed: () {
                            print(name); //the current name
                            _showEditNameDialog();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller:
                                TextEditingController(text: phoneNumber),
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Center the column horizontally
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _showDeleteConfirmationDialog();
                              },
                              child: Text(
                                'Delete Account',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromRGBO(255, 0, 0, 1),
                                fixedSize: Size(200, 60),
                              ),
                            ),
                            SizedBox(height: 25), // Add some vertical spacing
                            ElevatedButton(
                              onPressed: () {
                                _showSignOutConfirmationDialog();
                              },
                              child: Text(
                                'Sign Out',
                                style: TextStyle(
                                  color:
                                      Colors.white, // Set text color to white
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size(200, 60),
                                primary:
                                    Batatis_Dark, // Set background color to Batatis_Dark
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ));
  }

 void _showEditNameDialog() {
  String errorMessage = '';
  String regOnlyCharAndSpace = r'[A-Za-z\s]';


  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text('Edit Your Name'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  maxLength: 10,
                  decoration: InputDecoration(labelText: 'New Name'),
                ),
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _nameController.clear();
                  Navigator.pop(context);
                  
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  String newName = _nameController.text;
                  print(newName);

                  if (newName.isNotEmpty) {
                    if (newName.length <= 10) {
                      if (RegExp(regOnlyCharAndSpace).hasMatch(newName)) {
                        if (!newName.contains('  ')) {
                          if(newName[0]!=' '){

                          try {
                            // Additional validation passed
                            
                            FirebaseFirestore.instance
                                .collection('Customers')
                                .doc(SharedPrefer.UserId)
                                .update({'name': newName});
                            SharedPrefer.UserName = newName;
                            
                            // Update successful, you may want to update the UI or show a success message
                            print('Your name has been updated successfully');
                            _nameController.clear();
                            Navigator.pop(context); // Close the dialog

                            // Show a SnackBar with feedback
                              ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Your name changed successfully!', style: TextStyle(color: Colors.white)),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.green, // Set the background color to green
                              ),
                            );
                              
                          } catch (error) {
                            // Handle errors, you may want to show an error message
                            print('Error updating name: $error');
                          }
                          }
                          else{
                             setState(() {
                            errorMessage =
                                "Name cannot start with a space.";
                          });
                          }

                        } else {
                          setState(() {
                            errorMessage =
                                "Name cannot contain more than one consecutive space.";
                          });
                        }
                      } else {
                        setState(() {
                          errorMessage =
                              "Name must contain only letters and spaces.";
                        });
                      }
                    } else {
                      setState(() {
                        errorMessage = "Name must be at most 10 characters.";
                      });
                    }
                  } else {
                    setState(() {
                      errorMessage = "Your name is empty please enter your name.";
                    });
                  }
                },
                child: Text('Save'),
              ),
            ],
          );
        },
      );
    },
  );
}


  void _showDeleteConfirmationDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Confirm Delete Account'),
        content: Text('Are you sure you want to delete your account?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final ap = Provider.of<AuthProvider>(context, listen: false);
              //String userId = '6aE6h2cAGza2p6y7Kw9lHmHNo8p2';

              try {
                // You might want to add additional logic here, like deleting associated data

                await FirebaseFirestore.instance
                    .collection('Customers')
                    .doc(SharedPrefer.UserId)
                    .delete();

                await ap.usersignout();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => CSignIn()),
                  ((route) => false),
                );
              } catch (error) {
                // Handle errors, you may want to show an error message
                print('Error deleting account: $error');
              }
            },
            child: Text(
              'Delete Account',
              style: TextStyle(color: const Color.fromRGBO(255, 0, 0, 1)),
            ),
          ),
        ],
      ),
    );
  }

  void _showSignOutConfirmationDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Confirm Sign Out'),
        content: Text('Are you sure you want to sign out?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final ap = Provider.of<AuthProvider>(context, listen: false);
              await ap.usersignout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => CSignIn()),
                ((route) => false),
              );
            },
            child: Text(
              'Sign Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
