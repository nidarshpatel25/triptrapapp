import 'package:flutter/material.dart';

void main() => runApp(TripTrapApp());

class TripTrapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Trap',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Arial'),
      home: LoginPage(),
    );
  }
}

// Reusable Gradient Scaffold with Drawer
class GradientScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  GradientScaffold({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: [
        IconButton(icon: Icon(Icons.search), onPressed: () => showSearch(context: context, delegate: PlaceSearchDelegate())),
      ]),
      drawer: AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue.shade100, Colors.blue.shade300]),
        ),
        child: child,
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(padding: EdgeInsets.zero, children: [
        UserAccountsDrawerHeader(
          accountName: Text("John Doe"),
          accountEmail: Text("john@example.com"),
          currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=5")),
        ),
        ListTile(leading: Icon(Icons.home), title: Text("Home"), onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TouristPlacesPage()))),
        ListTile(leading: Icon(Icons.book), title: Text("My Bookings"), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => MyBookingsPage()))),
        ListTile(leading: Icon(Icons.settings), title: Text("Settings"), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage()))),
        ListTile(leading: Icon(Icons.help), title: Text("Help"), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => HelpPage()))),
        ListTile(leading: Icon(Icons.logout), title: Text("Logout"), onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()))),
      ]),
    );
  }
}

class LoginPage extends StatelessWidget {
  final username = TextEditingController();
  final password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      title: "Login",
      child: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text("Welcome to Trip Trap", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextField(controller: username, decoration: InputDecoration(labelText: 'Username')),
              TextField(controller: password, decoration: InputDecoration(labelText: 'Password'), obscureText: true),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Login"),
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => TouristPlacesPage())),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class TouristPlacesPage extends StatelessWidget {
  final places = [
    {"name": "Goa", "img": "https://picsum.photos/200?1"},
    {"name": "Manali", "img": "https://picsum.photos/200?2"},
    {"name": "Jaipur", "img": "https://picsum.photos/200?3"},
    {"name": "Kerala", "img": "https://picsum.photos/200?4"},
  ];
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      title: "Select Tourist Place",
      child: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: places.length,
        itemBuilder: (_, i) => Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(places[i]['img']!, width: 50, height: 50, fit: BoxFit.cover),
            ),
            title: Text(places[i]['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => GuideBookingPage(place: places[i]['name']!)),
            ),
          ),
        ),
      ),
    );
  }
}

class GuideBookingPage extends StatelessWidget {
  final String place;
  final guides = ['Nidarsh', 'Sneha', 'Arjun', 'Priya'];
  GuideBookingPage({required this.place});
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      title: "Book Guide for $place",
      child: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: guides.length,
        itemBuilder: (_, i) => Card(
          child: ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=${i + 10}")),
            title: Text(guides[i]),
            trailing: ElevatedButton(
              child: Text("Book"),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PaymentPage(place: place, guide: guides[i]))),
            ),
          ),
        ),
      ),
    );
  }
}

List<Map<String, String>> bookings = [];

class PaymentPage extends StatelessWidget {
  final String place, guide;
  PaymentPage({required this.place, required this.guide});
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      title: "Payment",
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text("Tour Place: $place", style: TextStyle(fontSize: 18)),
          Text("Guide: $guide", style: TextStyle(fontSize: 18)),
          SizedBox(height: 30),
          ElevatedButton(
            child: Text("Pay ₹2000"),
            onPressed: () {
              bookings.add({"place": place, "guide": guide});
              Navigator.push(context, MaterialPageRoute(builder: (_) => ReviewPage()));
            },
          ),
        ]),
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
    return GradientScaffold(
      title: "Review & Rating",
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Rate Trip Trap", style: TextStyle(fontSize: 20)),
        Slider(value: rating, onChanged: (v) => setState(() => rating = v), divisions: 4, min: 1, max: 5, activeColor: Colors.amber, label: "${rating.toStringAsFixed(0)} Star"),
        ElevatedButton(
          child: Text("Submit Review"),
          onPressed: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Thank You!"),
              content: Text("You rated us $rating star(s)"),
              actions: [
                TextButton(
                  child: Text("Done"),
                  onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class MyBookingsPage extends StatefulWidget {
  @override
  _MyBookingsPageState createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      title: "My Bookings",
      child: bookings.isEmpty
          ? Center(child: Text("No bookings yet"))
          : ListView.builder(
              padding: EdgeInsets.all(12),
              itemCount: bookings.length,
              itemBuilder: (_, i) => Card(
                child: ListTile(
                  title: Text("${bookings[i]['place']} - ${bookings[i]['guide']}"),
                  trailing: TextButton(
                    child: Text("Cancel", style: TextStyle(color: Colors.red)),
                    onPressed: () => setState(() => bookings.removeAt(i)),
                  ),
                ),
              ),
            ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      title: "Settings",
      child: Center(child: Text("Settings Page - Coming Soon")),
    );
  }
}

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      title: "Help & FAQ",
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text("For any assistance, contact support@triptrap.com\n\nFAQ:\n1. How to book?\n2. How to cancel?\n3. Payment methods."),
      ),
    );
  }
}

// Search Feature
class PlaceSearchDelegate extends SearchDelegate {
  final places = ["Goa", "Manali", "Jaipur", "Kerala"];
  @override
  List<Widget> buildActions(BuildContext context) => [IconButton(icon: Icon(Icons.clear), onPressed: () => query = "")];
  @override
  Widget buildLeading(BuildContext context) => IconButton(icon: Icon(Icons.arrow_back), onPressed: () => close(context, null));
  @override
  Widget buildResults(BuildContext context) {
    final results = places.where((p) => p.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (_, i) => ListTile(
        title: Text(results[i]),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => GuideBookingPage(place: results[i]))),
      ),
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) => buildResults(context);
}
