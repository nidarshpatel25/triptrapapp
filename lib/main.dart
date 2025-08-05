import 'package:flutter/material.dart';

void main() {
  runApp(TripTrapApp());
}

class TripTrapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Trap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

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
                    Navigator.pushReplacement(
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
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: places.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(places[index]),
              trailing: Icon(Icons.arrow_forward_ios),
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
    );
  }
}

class GuideBookingPage extends StatelessWidget {
  final String place;
  final List<String> guides = ['Nidarsh', 'Sneha', 'Arjun', 'Priya', 'Shiva', 'Anitha'];

  GuideBookingPage({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Guide for $place")),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: guides.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(guides[index]),
              trailing: ElevatedButton(
                child: Text("Book"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentPage(place: place, guide: guides[index]),
                    ),
                  );
                },
              ),
            ),
          );
        },
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
        child: Column(
          children: [
            Text("Rate the Trip Trap App", style: TextStyle(fontSize: 20)),
            Slider(
              value: rating,
              onChanged: (newRating) {
                setState(() => rating = newRating);
              },
              divisions: 4,
              min: 1,
              max: 5,
              label: "${rating.toStringAsFixed(0)} Star",
              activeColor: Colors.amber,
            ),
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
    );
  }
}
