import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class TimerService {
  static final TimerService _instance = TimerService._internal();
  factory TimerService() => _instance;
  TimerService._internal();

  Timer? _timer;
  DateTime? _startTime;
  Duration _totalTime = Duration.zero;
  bool _isRunning = false;
  bool _isStarted = false;

  // Getters
  bool get isRunning => _isRunning;
  bool get isStarted => _isStarted;
  Duration get totalTime => _totalTime;
  DateTime? get startTime => _startTime;

  // Initialize timer service
  Future<void> initialize() async {
    await _loadTimerState();
  }

  // Start timer
  Future<void> startTimer() async {
    if (!_isStarted) {
      // First time starting
      _startTime = DateTime.now();
      _isStarted = true;
    } else {
      // Resume from pause
      _startTime = DateTime.now();
    }
    
    _isRunning = true;
    _startTimer();
    await _saveTimerState();
  }

  // Stop timer
  Future<void> stopTimer() async {
    if (_isRunning && _startTime != null) {
      final now = DateTime.now();
      final elapsed = now.difference(_startTime!);
      _totalTime += elapsed;
      _isRunning = false;
      _startTime = null;
      _timer?.cancel();
      await _saveTimerState();
    }
  }

  // Reset timer
  Future<void> resetTimer() async {
    _timer?.cancel();
    _isRunning = false;
    _isStarted = false;
    _startTime = null;
    _totalTime = Duration.zero;
    await _saveTimerState();
  }

  // Get current elapsed time
  Duration getCurrentElapsedTime() {
    if (_isRunning && _startTime != null) {
      final now = DateTime.now();
      return _totalTime + now.difference(_startTime!);
    }
    return _totalTime;
  }

  // Format duration to HH:MM:SS
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  // Private methods
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Timer updates every second
      // You can add callback here if needed
    });
  }

  Future<void> _saveTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRunning', _isRunning);
    await prefs.setBool('isStarted', _isStarted);
    await prefs.setInt('totalTimeSeconds', _totalTime.inSeconds);
    if (_startTime != null) {
      await prefs.setInt('startTimeMillis', _startTime!.millisecondsSinceEpoch);
    } else {
      await prefs.remove('startTimeMillis');
    }
  }

  Future<void> _loadTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    _isRunning = prefs.getBool('isRunning') ?? false;
    _isStarted = prefs.getBool('isStarted') ?? false;
    final totalTimeSeconds = prefs.getInt('totalTimeSeconds') ?? 0;
    _totalTime = Duration(seconds: totalTimeSeconds);
    
    final startTimeMillis = prefs.getInt('startTimeMillis');
    if (startTimeMillis != null) {
      _startTime = DateTime.fromMillisecondsSinceEpoch(startTimeMillis);
    }

    // If timer was running when app was closed, continue it
    if (_isRunning && _startTime != null) {
      _startTimer();
    }
  }

  void dispose() {
    _timer?.cancel();
  }
} 