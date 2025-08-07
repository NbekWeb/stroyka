import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/navigation/projects_bottom_navigation.dart';
import 'timeline/home_page.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  int _selectedNavIndex = 0;

  final List<ProjectData> _projects = [
    ProjectData(
      title: 'Ludvika',
      address: 'Gruvrisvägen 70, 791 61 Falun',
      dateRange: '2 jul 2025 - 1 aug 2025',
      status: ProjectStatus.inProgress,
    ),
    ProjectData(
      title: 'Gruvrisvägen 70, 791 61...',
      address: 'Gruvrisvägen 70, 791 61 Falun',
      dateRange: '2 jul 2025 - 1 aug 2025',
      status: ProjectStatus.inProgress,
    ),
    ProjectData(
      title: 'Gruvrisvägen 70, 791 61...',
      address: 'Gruvrisvägen 70, 791 61 Falun',
      dateRange: '2 jul 2025 - 1 aug 2025',
      status: ProjectStatus.inProgress,
    ),
    ProjectData(
      title: 'Gruvrisvägen 70, 791 61...',
      address: 'Gruvrisvägen 70, 791 61 Falun',
      dateRange: '2 jul 2025 - 1 aug 2025',
      status: ProjectStatus.done,
    ),
    ProjectData(
      title: 'Gruvrisvägen 70, 791 61...',
      address: 'Gruvrisvägen 70, 791 61 Falun',
      dateRange: '2 jul 2025 - 1 aug 2025',
      status: ProjectStatus.inProgress,
    ),
    ProjectData(
      title: 'Gruvrisvägen 70, 791 61...',
      address: 'Gruvrisvägen 70, 791 61 Falun',
      dateRange: '2 jul 2025 - 1 aug 2025',
      status: ProjectStatus.done,
    ),
  ];

  void _onNavTap(int index) {
    setState(() {
      _selectedNavIndex = index;
    });
    
    if (index == 0) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 238, 245, 251),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),
            
            // Projects list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                itemCount: _projects.length,
                itemBuilder: (context, index) {
                  return _buildProjectCard(_projects[index]);
                },
              ),
            ),
            
            // Bottom navigation
            ProjectsBottomNavigation(
              selectedIndex: _selectedNavIndex,
              onHomeTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                  (route) => false,
                );
              },
              onMenuTap: () {
                // TODO: Handle menu tap
              },
              onAddTap: () {
                // TODO: Handle add project
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
                Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Row(
            children: [
              // Back button
              Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                      (route) => false,
                    );
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: SizedBox(
                          width: 44,
                          height: 44,
                          child: Image.asset(
                            'assets/img/bg.png',
                            width: 44,
                            height: 44,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                            ),
                        child: const Icon(
                          Icons.chevron_left,
                          color: Color.fromARGB(255, 64, 64, 64),
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const Spacer(),
              
              // Search button (no action for now)
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    image: const DecorationImage(
                      image: AssetImage('assets/img/bg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Icon(
                    Icons.search,
                    color: Colors.black87,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Title
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Projects',
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 5, 45, 80),
              ),
            ),
          ),
        ),
        
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildProjectCard(ProjectData project) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  project.title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              _buildStatusTag(project.status),
            ],
          ),
          
          SizedBox(height: 8.h),
          
          Row(
            children: [
              SvgPicture.asset(
                'assets/icon/locflag.svg',
                width: 17,
                height: 17,
                colorFilter: ColorFilter.mode(
                  Colors.grey[600]!,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  project.address,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 8.h),
          
          Row(
            children: [
              SvgPicture.asset(
                'assets/icon/calendar.svg',
                width: 17,
                height: 17,
                colorFilter: ColorFilter.mode(
                  Colors.grey[600]!,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                project.dateRange,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTag(ProjectStatus status) {
    Color backgroundColor;
    Color textColor;
    String text;
    
    switch (status) {
      case ProjectStatus.inProgress:
        backgroundColor = const Color(0xFFE3F2FD);
        textColor = const Color(0xFF1976D2);
        text = 'In progress';
        break;
      case ProjectStatus.done:
        backgroundColor = const Color(0xFFE8F5E8);
        textColor = const Color(0xFF2E7D32);
        text = 'Done';
        break;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }
}

class ProjectData {
  final String title;
  final String address;
  final String dateRange;
  final ProjectStatus status;

  ProjectData({
    required this.title,
    required this.address,
    required this.dateRange,
    required this.status,
  });
}

enum ProjectStatus {
  inProgress,
  done,
} 