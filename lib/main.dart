import 'package:flutter/material.dart';

void main() {
  runApp(TripTrapApp());
}

class TripTrapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Trap',
      theme: ThemeData(
        primaryColor: AppColors.primaryBlue,
        scaffoldBackgroundColor: AppColors.lightBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: AppColors.accentGreen,
            foregroundColor: Colors.white,
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppColors {
  static const Color primaryBlue = Color(0xFF0D47A1);
  static const Color accentGreen = Color(0xFF00C853);
  static const Color lightBackground = Color(0xFFF5F5F5);
  static const Color goldenStar = Color(0xFFFFD700);
}

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trip Trap - Login")),
      body: Center(
        child: Card(
          elevation: 8,
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text("Login / Create Account"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TouristPlacesPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TouristPlacesPage extends StatelessWidget {
  final List<String> places = ['Goa', 'Manali', 'Jaipur', 'Kerala', 'Arunachalam', 'Tirupathi'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Tourist Places")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.blue[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: places.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(places[index],
                    style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primaryBlue)),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.blueAccent),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GuideBookingPage(place: places[index]),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class GuideBookingPage extends StatelessWidget {
  final String place;
  final List<String> guides = ['Nidarsh', 'Sneha', 'Arjun', 'Priya', 'Shiva', 'Anitha'];

  GuideBookingPage({required this.place});

  Color getButtonColor(int index) {
    final colors = [Colors.green, Colors.orange, Colors.purple, Colors.teal];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Guide for $place")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.green[50]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: guides.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(guides[index], style: TextStyle(fontWeight: FontWeight.w600)),
                trailing: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: getButtonColor(index),
                  ),
                  child: Text("Book"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PaymentPage(place: place, guide: guides[index])),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PaymentPage extends StatelessWidget {
  final String place;
  final String guide;

  PaymentPage({required this.place, required this.guide});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment for $place")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 10,
          shadowColor: Colors.blueAccent.withOpacity(0.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.blue[50]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Tour Place: $place", style: TextStyle(fontSize: 18)),
                  Text("Guide: $guide", style: TextStyle(fontSize: 18)),
                  SizedBox(height: 30),
                  ElevatedButton(
                    child: Text("Pay ₹2000"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReviewPage()),
                      );
                    },
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

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  double rating = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Review & Rating")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Rate the Trip Trap App", style: TextStyle(fontSize: 20)),
                SizedBox(height: 20),
                Slider(
                  value: rating,
                  onChanged: (newRating) {
                    setState(() => rating = newRating);
                  },
                  divisions: 4,
                  min: 1,
                  max: 5,
                  label: "${rating.toStringAsFixed(0)} Star",
                  activeColor: AppColors.goldenStar,
                  inactiveColor: Colors.grey[300],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text("Submit Review"),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("Thank You!"),
                        content: Text("You rated us $rating star(s)"),
                        actions: [
                          TextButton(
                            child: Text("Done"),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).popUntil((route) => route.isFirst);
                            },
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}