// Define the interface as a class with method declarations
abstract class Vehicle {
  void start();
  void stop();
}

mixin LoggerMixin {
  void log(String message) {
    final now = DateTime.now();
    print('[${now.toIso8601String()}] $message');
  }
}

mixin HighMixin {
  void high(String message) {
    final now = DateTime.now();
    print('[${now.toIso8601String()}] $message');
  }
}

class Animal {
  void bark(String message) {
    final now = DateTime.now();
    print('[${now.toIso8601String()}] $message');
  }
}

// Implementing the interface in a class
 class Car extends Animal with LoggerMixin,HighMixin implements Vehicle {
  @override
  void start() {
    print("Car started");
    log("jdsds");
  }
  @override
  void stop() {
    bark("message");
    high("message");
  }
}
