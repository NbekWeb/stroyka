import 'package:flutter/material.dart';
import '../../pages/project_selection_page.dart';

class ProjectDropdown extends StatelessWidget {
  final String selectedProject;
  final List<String> projects;
  final Function(String) onChanged;

  const ProjectDropdown({
    super.key,
    required this.selectedProject,
    required this.projects,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProjectSelectionPage(
                  currentProject: selectedProject,
                  projects: projects,
                  onProjectSelected: (project) {
                    onChanged(project);
                  },
                ),
              ),
            );
          },
          child: Container(
            height: 42,
            width: 283,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Colors.white.withAlpha((255 * 0.2).toInt()),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedProject,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 