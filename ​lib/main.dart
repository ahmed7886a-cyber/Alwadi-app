import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const AlwadiApp());

}

class AlwadiApp extends StatelessWidget {

  const AlwadiApp({super.key});

  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'الوادي للمقاولات',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(

        primarySwatch: Colors.green,

        scaffoldBackgroundColor: const Color(0xFFF1F8E9),

        fontFamily: 'Roboto',

      ),

      home: StreamBuilder<User?>(

        stream: FirebaseAuth.instance.authStateChanges(),

        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {

            return const Scaffold(body: Center(child: CircularProgressIndicator()));

          }

          if (snapshot.hasData) {

            return const MainDashboardScreen();

          }

          return const LoginScreen();

        },

      ),

    );

  }

}

class LoginScreen extends StatefulWidget {

  const LoginScreen({super.key});

  @override

  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _login() async {

    setState(() => _isLoading = true);

    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(

        email: _emailController.text.trim(),

        password: _passwordController.text.trim(),

      );

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(content: Text('خطأ في تسجيل الدخول: ${e.toString()}')),

      );

    } finally {

      if (mounted) setState(() => _isLoading = false);

    }

  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(24.0),

          child: Card(

            elevation: 8,

            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

            child: Padding(

              padding: const EdgeInsets.all(24.0),

              child: Column(

                mainAxisSize: MainAxisSize.min,

                children: [

                  Image.network(

                    'https://i.ibb.co/L5T1mG6/1000028329.jpg',

                    height: 120,

                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.agriculture, size: 80, color: Colors.green),

                  ),

                  const SizedBox(height: 16),

                  const Text(

                    'الوادي للمقاولات والخدمات الزراعية',

                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),

                    textAlign: TextAlign.center,

                  ),

                  const SizedBox(height: 24),

                  TextField(

                    controller: _emailController,

                    decoration: const InputDecoration(

                      labelText: 'البريد الإلكتروني',

                      border: OutlineInputBorder(),

                      prefixIcon: Icon(Icons.email),

                    ),

                    keyboardType: TextInputType.emailAddress,

                  ),

                  const SizedBox(height: 16),

                  TextField(

                    controller: _passwordController,

                    obscureText: true,

                    decoration: const InputDecoration(

                      labelText: 'كلمة المرور',

                      border: OutlineInputBorder(),

                      prefixIcon: Icon(Icons.lock),

                    ),

                  ),

                  const SizedBox(height: 24),

                  _isLoading

                      ? const CircularProgressIndicator()

                      : ElevatedButton(

                          onPressed: _login,

                          style: ElevatedButton.styleFrom(

                            backgroundColor: Colors.green[800],

                            minimumSize: const Size(double.infinity, 50),

                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),

                          ),

                          child: const Text('تسجيل الدخول', style: TextStyle(fontSize: 18, color: Colors.white)),

                        ),

                ],

              ),

            ),

          ),

        ),

      ),

    );

  }

}

class MainDashboardScreen extends StatelessWidget {

  const MainDashboardScreen({super.key});

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('الصفحة الرئيسية'),

        backgroundColor: Colors.green[800],

        actions: [

          IconButton(

            icon: const Icon(Icons.logout),

            onPressed: () => FirebaseAuth.instance.signOut(),

          )

        ],

      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20.0),

        child: Column(

          children: [

            Card(

              elevation: 6,

              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

              child: Padding(

                padding: const EdgeInsets.all(20.0),

                child: Column(

                  children: [

                    ClipRRect(

                      borderRadius: BorderRadius.circular(12),

                      child: Image.network(

                        'https://i.ibb.co/L5T1mG6/1000028329.jpg',

                        height: 150,

                        fit: BoxFit.cover,

                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.agriculture, size: 100, color: Colors.green),

                      ),

                    ),

                    const SizedBox(height: 16),

                    const Text(

                      'شركة الوادي للمقاولات والخدمات الزراعية',

                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),

                      textAlign: TextAlign.center,

                    ),

                    const Divider(height: 30, thickness: 1.5),

                    const ListTile(

                      leading: Icon(Icons.person, color: Colors.green, size: 30),

                      title: Text('مدير الشركة', style: TextStyle(fontSize: 14, color: Colors.grey)),

                      subtitle: Text('م / أحمد عبيد أحمد', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                    ),

                    const ListTile(

                      leading: Icon(Icons.person_outline, color: Colors.green, size: 30),

                      title: Text('نائب المدير', style: TextStyle(fontSize: 14, color: Colors.grey)),

                      subtitle: Text('م / كارم عبيد أحمد', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                    ),

                  ],

                ),

              ),

            ),

            const SizedBox(height: 30),

            ElevatedButton.icon(

              style: ElevatedButton.styleFrom(

                backgroundColor: Colors.green[800],

                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),

                minimumSize: const Size(double.infinity, 60),

                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

              ),

              icon: const Icon(Icons.badge, size: 28, color: Colors.white),

              label: const Text(

                'إدارة حضور وإنتاجية العمال',

                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),

              ),

              onPressed: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(builder: (context) => const AttendanceScreen()),

                );

              },

            ),

          ],

        ),

      ),

    );

  }

}

class AttendanceScreen extends StatefulWidget {

  const AttendanceScreen({super.key});

  @override

  State<AttendanceScreen> createState() => _AttendanceScreenState();

}

class _AttendanceScreenState extends State<AttendanceScreen> {

  DateTime _selectedDate = DateTime.now();

  @override

  Widget build(BuildContext context) {

    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);

    return Scaffold(

      appBar: AppBar(

        title: const Text('إدارة الحضور والإنتاجية'),

        backgroundColor: Colors.green[800],

      ),

      body: Column(

        children: [

          Container(

            color: Colors.green[100],

            padding: const EdgeInsets.all(12),

            child: Row(

              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text(

                  'التاريخ: $formattedDate',

                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),

                ),

                ElevatedButton.icon(

                  onPressed: () async {

                    DateTime? picked = await showDatePicker(

                      context: context,

                      initialDate: _selectedDate,

                      firstDate: DateTime(2024),

                      lastDate: DateTime(2030),

                    );

                    if (picked != null) setState(() => _selectedDate = picked);

                  },

                  icon: const Icon(Icons.calendar_today),

                  label: const Text('تغيير التاريخ'),

                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green[700]),

                ),

              ],

            ),

          ),

          Expanded(

            child: StreamBuilder<QuerySnapshot>(

              stream: FirebaseFirestore.instance.collection('workers').snapshots(),

              builder: (context, snapshot) {

                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

                var workers = snapshot.data!.docs;

                if (workers.isEmpty) {

                  return const Center(child: Text('لا يوجد عمال مضافين بعد. اضغط + لإضافة عامل.'));

                }

                return ListView.builder(

                  itemCount: workers.length,

                  itemBuilder: (context, index) {

                    var worker = workers[index];

                    String workerId = worker.id;

                    String workerName = worker['name'];

                    return StreamBuilder<DocumentSnapshot>(

                      stream: FirebaseFirestore.instance

                          .collection('attendance')

                          .doc('${formattedDate}_$workerId')

                          .snapshots(),

                      builder: (context, attSnapshot) {

                        bool isPresent = false;

                        double wage = 270.0;

                        if (attSnapshot.hasData && attSnapshot.data!.exists) {

                          var data = attSnapshot.data!.data() as Map<String, dynamic>;

                          isPresent = data['present'] ?? false;

                          wage = (data['wage'] ?? 270.0).toDouble();

                        }

                        return Card(

                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

                          child: ListTile(

                            title: Text(workerName, style: const TextStyle(fontWeight: FontWeight.bold)),

                            subtitle: Text(isPresent ? 'حاضر - الأجر: $wage ج.م' : 'غائب'),

                            trailing: Switch(

                              value: isPresent,

                              activeColor: Colors.green,

                              onChanged: (val) {

                                FirebaseFirestore.instance

                                    .collection('attendance')

                                    .doc('${formattedDate}_$workerId')

                                    .set({

                                  'workerId': workerId,

                                  'workerName': workerName,

                                  'date': formattedDate,

                                  'present': val,

                                  'wage': val ? 270.0 : 0.0,

                                });

                              },

                            ),

                          ),

                        );

                      },

                    );

                  },

                );

              },

            ),

          ),

        ],

      ),

      floatingActionButton: FloatingActionButton(

        backgroundColor: Colors.green[800],

        onPressed: () => _addWorkerDialog(context),

        child: const Icon(Icons.add),

      ),

    );

  }

  void _addWorkerDialog(BuildContext context) {

    final nameController = TextEditingController();

    showDialog(

      context: context,

      builder: (context) => AlertDialog(

        title: const Text('إضافة عامل جديد'),

        content: TextField(

          controller: nameController,

          decoration: const InputDecoration(hintText: 'اسم العامل'),

        ),

        actions: [

          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),

          ElevatedButton(

            onPressed: () {

              if (nameController.text.trim().isNotEmpty) {

                FirebaseFirestore.instance.collection('workers').add({

                  'name': nameController.text.trim(),

                  'createdAt': FieldValue.serverTimestamp(),

                });

                Navigator.pop(context);

              }

            },

            child: const Text('إضافة'),

          ),

        ],

      ),

    );

  }

}