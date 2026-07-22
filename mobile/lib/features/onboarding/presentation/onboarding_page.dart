import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              const Icon(
                Icons.home_rounded,
                size: 110,
                color: Colors.blue,
              ),

              const SizedBox(height: 30),

              const Text(
                'HomeCheck',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                'Check your home before\nleaving with confidence.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 40),

              const ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('Turn off the stove'),
              ),

              const ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('Unplug the iron'),
              ),

              const ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('Close the windows'),
              ),

              const ListTile(
                leading: Icon(Icons.check_circle, color: Colors.green),
                title: Text('Switch off the lights'),
              ),

              const Spacer(),

              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              TextButton(
                onPressed: () {},
                child: const Text('Skip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}