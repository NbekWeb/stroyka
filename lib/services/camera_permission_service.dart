import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/custom_toast.dart';

class CameraPermissionService {
  static Future<bool> requestCameraPermission(BuildContext context) async {
    try {
      // Check current permission status
      PermissionStatus status = await Permission.camera.status;
      
      // If permission is already granted, return true
      if (status.isGranted) {
        return true;
      }
      
      // If permission is permanently denied, show settings dialog
      if (status.isPermanentlyDenied) {
        if (!context.mounted) return false;
        return await _showSettingsDialog(context);
      }
      
      // If permission is denied, request it
      if (status.isDenied) {
        // Request permission directly (iOS will show native permission dialog)
        status = await Permission.camera.request();
        
        if (status.isGranted) {
          return true;
        } else if (status.isPermanentlyDenied) {
          if (!context.mounted) return false;
          return await _showSettingsDialog(context);
        } else {
          // Show error message
          if (context.mounted) {
            CustomToast.showTopToast(
              context,
              'Camera permission is required to use this feature',
              type: ToastType.error,
            );
          }
          return false;
        }
      }
      
      return false;
    } catch (e) {
      print('Error requesting camera permission: $e');
      if (context.mounted) {
        CustomToast.showTopToast(
          context,
          'Failed to request camera permission',
          type: ToastType.error,
        );
      }
      return false;
    }
  }
  
  static Future<bool> _showSettingsDialog(BuildContext context) async {
    if (!context.mounted) return false;
    
    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Camera Permission Required'),
          content: const Text(
            'Camera permission is required to take photos. Please enable it in your device settings.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop(true);
                await openAppSettings();
              },
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    ) ?? false;
  }
  
  static Future<bool> checkCameraPermission() async {
    try {
      PermissionStatus status = await Permission.camera.status;
      return status.isGranted;
    } catch (e) {
      print('Error checking camera permission: $e');
      return false;
    }
  }
} 