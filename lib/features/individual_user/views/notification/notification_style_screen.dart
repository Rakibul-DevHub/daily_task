import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_texts_style.dart';

class NotificationStyleScreen extends StatefulWidget {
  const NotificationStyleScreen({super.key});

  @override
  State<NotificationStyleScreen> createState() =>
      _NotificationStyleScreenState();
}

class _NotificationStyleScreenState extends State<NotificationStyleScreen> {
  String _selectedOption = 'gentle';
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
    // Auto-play gentle sound when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playSampleSound('gentle');
    });
  }

  void _setupAudioPlayer() {
    // Set audio context for better compatibility
    _audioPlayer.setReleaseMode(ReleaseMode.stop);

    // Listen to player state changes
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (mounted) {
        setState(() {
          _isPlaying = state == PlayerState.playing;
        });
        debugPrint('🎵 Player state: $state');
      }
    });

    // Listen for completion
    _audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          _isPlaying = false;
        });
        debugPrint('✅ Sound finished playing');
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _selectOption(String option) async {
    // Stop any currently playing sound
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
      });
    }

    setState(() {
      _selectedOption = option;
    });

    // Play sample sound for gentle and firm options
    if (option == 'gentle' || option == 'firm') {
      await _playSampleSound(option);
    }
  }

  Future<void> _playSampleSound(String option) async {
    try {
      setState(() {
        _isPlaying = true;
      });

      // Stop any currently playing sound first
      await _audioPlayer.stop();

      // Different sound files for different notification styles
      String soundPath;
      if (option == 'gentle') {
        soundPath = 'tune/gentle_notification.mp3';
      } else {
        soundPath = 'tune/firm_notification.mp3';
      }

      debugPrint('🎵 Attempting to play: $soundPath');

      // Play the sound from assets with proper source
      await _audioPlayer.play(
        AssetSource(soundPath),
        volume: 1.0,
      );

      debugPrint('✅ Play command executed successfully');

    } catch (e) {
      debugPrint('❌ Error playing sound: $e');
      if (mounted) {
        setState(() {
          _isPlaying = false;
        });

        // Show error message with detailed help
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Audio file not found: $e'),
            duration: const Duration(seconds: 4),
            backgroundColor: Colors.red[700],
            action: SnackBarAction(
              label: 'Setup Help',
              textColor: Colors.white,
              onPressed: _showHelpDialog,
            ),
          ),
        );
      }
    }
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: const [
              Icon(Icons.info_outline, color: AppColors.primaryColor),
              SizedBox(width: 8),
              Text('Audio Files Setup'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Please follow these steps:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Step 1
                _buildSetupStep(
                  '1',
                  'Create audio files folder',
                  'Create a folder: assets/tune/',
                ),
                const SizedBox(height: 12),

                // Step 2
                _buildSetupStep(
                  '2',
                  'Add MP3 files',
                  'Place these files in assets/tune/:\n• gentle_notification.mp3\n• firm_notification.mp3',
                ),
                const SizedBox(height: 12),

                // Step 3
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.primaryColor.withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Update pubspec.yaml',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'flutter:\n  assets:\n    - assets/icons/\n    - assets/tune/',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Step 4
                _buildSetupStep(
                  '4',
                  'Run commands',
                  'Execute in terminal:\nflutter clean\nflutter pub get\nflutter run',
                ),

                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.lightbulb_outline, color: Colors.orange, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Tip: You can use any MP3 files for testing. Just rename them accordingly.',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it!'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSetupStep(String number, String title, String description) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Text(
              description,
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _testNotificationSound() async {
    // Stop any currently playing sound
    if (_isPlaying) {
      await _audioPlayer.stop();
    }

    // Play the selected notification style sound
    await _playSampleSound(_selectedOption);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Notification Style', style: AppTextStyles.smallHeading),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: AppColors.cardBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header with icon and title
                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/notification_square.svg",
                        height: 40,
                        width: 40,
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Notification Style',
                              style: AppTextStyles.defaultTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'How reminders should feel',
                              style: AppTextStyles.defaultTextStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Option Tiles
                  _buildOptionTile(
                    key: 'gentle',
                    title: 'Gentle',
                    subtitle: 'Soft and non-intrusive • Tap to hear sample',
                    isSelected: _selectedOption == 'gentle',
                    isPlaying: _isPlaying && _selectedOption == 'gentle',
                    onTap: () => _selectOption('gentle'),
                  ),

                  const SizedBox(height: 16),

                  _buildOptionTile(
                    key: 'firm',
                    title: 'Firm',
                    subtitle: 'Clear and noticeable • Tap to hear sample',
                    isSelected: _selectedOption == 'firm',
                    isPlaying: _isPlaying && _selectedOption == 'firm',
                    onTap: () => _selectOption('firm'),
                  ),

                  const SizedBox(height: 16),

                  _buildOptionTile(
                    key: 'silent',
                    title: 'Silent',
                    subtitle: 'Notification will not be provided',
                    isSelected: _selectedOption == 'silent',
                    isPlaying: false,
                    onTap: () => _selectOption('silent'),
                  ),

                  // Save button
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Save the selected option
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Notification style set to $_selectedOption'),
                            duration: const Duration(seconds: 2),
                            backgroundColor: AppColors.primaryColor,
                          ),
                        );
                        Navigator.pop(context, _selectedOption);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save Preference',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required String key,
    required String title,
    required String subtitle,
    required bool isSelected,
    required bool isPlaying,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12.0),
          color: isSelected ? AppColors.lightBlueColor : Colors.white,
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppColors.primaryColor.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ]
              : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            // Dynamic icon based on selection and playing state
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: isPlaying
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                  ),
                )
                    : Icon(
                  key == 'gentle'
                      ? Icons.volume_down
                      : key == 'firm'
                      ? Icons.volume_up
                      : Icons.volume_off,
                  color: isSelected ? AppColors.primaryColor : Colors.grey,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.smallHeading.copyWith(
                          fontSize: 16,
                          color: isSelected ? AppColors.primaryColor : null,
                          fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                      if (isPlaying) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Playing...',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Custom toggle indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 44,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    top: 2,
                    left: isSelected ? 22 : 2,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}