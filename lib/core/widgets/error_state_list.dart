import 'package:flutter/material.dart';


void main() {
  runApp( MaterialApp(
    home: Scaffold(
      body: ErrorStateList(
      imageAssetName: 'assets/images/error.png', 
      errorMessage: 'No Internet Connection',
      onRetry: () {
        debugPrint("Reload the page");
      },
      
      ),
      ),
    ));
}

class ErrorStateList extends StatelessWidget {
  final String imageAssetName;
  final String errorMessage;
  final VoidCallback onRetry;

  const ErrorStateList({
    super.key,
    required this.imageAssetName,
    required this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageAssetName, height: 100, width: 100),
            const SizedBox(height: 16),
            const Text("Something went wrong...",
              style: TextStyle(fontSize: 18),
            
            ),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: onRetry,
              child: const Text("Try Again"),
            ),
            const Text("or"),
            TextButton(onPressed: () {}, child: const Text("Contact Support")),
          ],
        ),
      ),
    );
  }
}