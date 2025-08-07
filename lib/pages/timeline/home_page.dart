import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/index.dart';
import '../../components/timer/timer_display.dart';
import '../../components/timer/timeline_progress.dart';
import '../../components/timer/play_button.dart';
import '../../components/header/project_dropdown.dart';
import '../../components/action_cards/responsive_action_cards_grid.dart';
import '../../components/navigation/bottom_navigation.dart';
import '../tracker_page.dart';
import '../settings_page.dart';
import '../legal_policies_page.dart';
import '../camera_page.dart';
import '../projects_page.dart';
import '../../services/timer_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showMenuModal = false;
  final TimerService _timerService = TimerService();
  String _currentTime = '00:00:00';
  Timer? _updateTimer;
  bool isRunning = false;
  int totalSeconds = 0;
  int progressIndex = 0;
  Timer? _timer;
  String _selectedProject = 'Select or create project';
  final List<String> _projects = [
    'sProject 1',
    'Psroject 2',
    'Project 3',
    'Project 4',
    'Project 5',
    'Project 6',
    'Project 7',
    'Project 8',
    'Project 9',
    'Project 10',
  ];
  int _selectedNavIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeTimer();
  }

  @override
  void dispose() {
    _updateTimer?.cancel();
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _initializeTimer() async {
    await _timerService.initialize();
    _startUpdateTimer();
  }

  void _startUpdateTimer() {
    _updateTimer?.cancel();
    _updateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _currentTime = _timerService.formatDuration(_timerService.getCurrentElapsedTime());
        });
      }
    });
  }

  void _toggleTimer() {
    
    if (isRunning) {
      // Stop timer
      setState(() {
        isRunning = false;
      });
      _timer?.cancel();
    } else {
      // Start timer
      setState(() {
        isRunning = true;
        if (totalSeconds == 0) {
          totalSeconds = 0;
          progressIndex = 0;
        }
      });
      
      // Start the timer
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (mounted) {
          setState(() {
            totalSeconds++;
            // Progress based on total hours
            int totalHours = (totalSeconds / 3600).floor();
            progressIndex = totalHours;
            if (progressIndex > 9) progressIndex = 9;
          });
        }
      });
    }
  }

  void _onProjectChanged(String value) {
    setState(() {
      _selectedProject = value;
      // Stop timer when project is changed
      
    });
  }

  void _onNavTap(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
    
    if (index == 1) {
      setState(() {
        _showMenuModal = true;
      });
    }
  }

  List<ResponsiveActionCardData> _getActionCards() {
    return [
      ResponsiveActionCardData(
        iconPath: 'assets/icon/camera.svg',
        label: 'Camera',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CameraPage()),
          );
        },
      ),
      ResponsiveActionCardData(
        iconPath: 'assets/icon/chat.svg',
        label: 'Chat',
        onTap: () {
          // Navigate to chat page
        },
      ),
      ResponsiveActionCardData(
        iconPath: 'assets/icon/istory.svg',
        label: 'Shift history',
        onTap: () {
          // Navigate to shift history page
        },
      ),
      ResponsiveActionCardData(
        iconPath: 'assets/icon/project.svg',
        label: 'Projects',
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProjectsPage()),
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isRunning 
                    ? [
                        const Color(0xFF2394FF), // #2394FF
                        const Color(0xFF043E73), // #043E73
                        const Color(0xFF000509), // #000509
                      ]
                    : [
                        const Color(0xFF00203A), // #00203A
                        const Color(0xFF000509), // #000509
                      ],
                stops: isRunning 
                    ? [0.0, 0.0962, 0.2308]
                    : [0.0385, 0.2163],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Header section
                  ProjectDropdown(
                    selectedProject: _selectedProject,
                    projects: _projects,
                    onChanged: _onProjectChanged,
                  ),
                  
                  // Main content
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20.h),
                          
                          // Timer display
                          TimerDisplay(totalSeconds: totalSeconds),
                          
                          SizedBox(height: 30.h),
                          
                          // Timeline progress
                          TimelineProgress(progressIndex: progressIndex),
                          
                          SizedBox(height: 30.h),
                          
                          // Play button
                          PlayButton(
                            isRunning: isRunning,
                            onTap: _toggleTimer,
                          ),
                          
                          SizedBox(height: 30.h),
                          
                          // Action cards grid
                          ResponsiveActionCardsGrid(cards: _getActionCards()),
                          
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                  
                  // Bottom navigation
                  BottomNavigation(
                    selectedIndex: _selectedNavIndex,
                    onTap: _onNavTap,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_showMenuModal) _buildMenuModal(),
      ],
    );
  }

  Widget _buildMenuModal() {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          margin: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10.h),
                blurRadius: 20,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close button
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showMenuModal = false;
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.all(16.w),
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black87,
                      size: 20,
                    ),
                  ),
                ),
              ),
              // Menu options
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  children: [
                    _buildMenuOption('Tasks'),
                    _buildMenuOption('Documents'),
                    _buildMenuOption('Tracker'),
                    _buildMenuOption('Projekts'),
                    _buildMenuOption('Work shifts'),
                    _buildMenuOption('Settings'),
                    _buildMenuOption('Support'),
                    _buildMenuOption('Account'),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption(String title) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8.h),
      child: ElevatedButton(
        onPressed: () {
          // Handle menu option tap
          setState(() {
            _showMenuModal = false;
          });
          
          // Navigate to Tracker page if Tracker is selected
          if (title == 'Tracker') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TrackerPage()),
            );
          }
          // Navigate to Settings page if Settings is selected
          if (title == 'Settings') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          }
          // Navigate to Legal & Policies page if Legal & Policies is selected
          if (title == 'Legal & Policies') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LegalPoliciesPage()),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE1F4FF),
          foregroundColor: Colors.black87,
          padding: EdgeInsets.symmetric(vertical: 15.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.r),
          ),
          elevation: 0,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
