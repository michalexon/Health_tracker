import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tracker Zdrowia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tracker Zdrowia'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CalorieTracker(),
                SizedBox(height: 20),
                WaterTracker(),
                SizedBox(height: 20),
                BodyStatsTracker(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CalorieTracker extends StatefulWidget {
  @override
  _CalorieTrackerState createState() => _CalorieTrackerState();
}

class _CalorieTrackerState extends State<CalorieTracker> {
  final _consumedController = TextEditingController();
  final _burnedController = TextEditingController();
  int _caloriesConsumed = 0;
  int _caloriesBurned = 0;

  void _updateCalories() {
    setState(() {
      _caloriesConsumed += int.tryParse(_consumedController.text) ?? 0;
      _caloriesBurned += int.tryParse(_burnedController.text) ?? 0;
      _consumedController.clear();
      _burnedController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    int _totalCalories = _caloriesConsumed - _caloriesBurned;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.redAccent, Colors.deepOrangeAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: <Widget>[
          Text('Łączna ilość kalorii: $_totalCalories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: _consumedController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Spożyte kalorie',
                        hintStyle: TextStyle(color: Colors.white70),
                        fillColor: Colors.white24,
                        filled: true,
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text('Spożyte: $_caloriesConsumed', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: _burnedController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Spalone kalorie',
                        hintStyle: TextStyle(color: Colors.white70),
                        fillColor: Colors.white24,
                        filled: true,
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text('Spalone: $_caloriesBurned', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _updateCalories,
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.red,
            ),
            child: Text('Aktualizuj'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _consumedController.dispose();
    _burnedController.dispose();
    super.dispose();
  }
}

class WaterTracker extends StatefulWidget {
  @override
  _WaterTrackerState createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  int _waterIntake = 0;

  void _addWater(int amount) {
    setState(() {
      _waterIntake += amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.lightBlueAccent, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Spożycie wody: $_waterIntake ml',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _addWater(250),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            child: Text('Dodaj 250ml wody'),
          ),
        ],
      ),
    );
  }
}

class BodyStatsTracker extends StatefulWidget {
  @override
  _BodyStatsTrackerState createState() => _BodyStatsTrackerState();
}

class _BodyStatsTrackerState extends State<BodyStatsTracker> {
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  double _currentWeight = 0.0;
  double _currentHeight = 0.0;
  double _bmi = 0.0;

  void _calculateBMI() {
    setState(() {
      _currentWeight = double.tryParse(_weightController.text) ?? 0.0;
      _currentHeight = double.tryParse(_heightController.text) ?? 0.0;
      if (_currentHeight > 0) {
        _bmi = _currentWeight / ((_currentHeight / 100) * (_currentHeight / 100));
      }
      _weightController.clear();
      _heightController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [Colors.grey[300]!, Colors.grey[500]!],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Twoje BMI wynosi: ${_bmi.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: 'Masa ciała (kg)',
                        hintStyle: TextStyle(color: Colors.white70),
                        fillColor: Colors.white24,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text('Masa ciała: $_currentWeight kg', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: 'Wzrost (cm)',
                        hintStyle: TextStyle(color: Colors.white70),
                        fillColor: Colors.white24,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text('Wzrost: $_currentHeight cm', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _calculateBMI,
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
            child: Text('Oblicz BMI'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }
}

