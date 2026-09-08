class AppUrl {
  AppUrl._();

  static const String baseUrl = 'https://tonmoy3001.sobhoy.com/api/v1';
  static const String imageBaseUrl = 'https://tonmoy3001.sobhoy.com';

  /// ============================================
  /// =================== Auth ===================
  /// ============================================
  static const String signUpIndevidual = '$baseUrl/auth/register/v2';
  static const String verifyEmail = '$baseUrl/auth/verify-email';
  static const String forgotPassword = '$baseUrl/auth/forgot-password';
  static const String resetPassword = '$baseUrl/auth/reset-password';
  static const String resendVerificationCode = '$baseUrl/auth/resend-otp';


  static const String loginIndividualAndChildren =
  // '$baseUrl/auth/login/individual-user';
      '$baseUrl/auth/login/v2';

  static const String googleSignIn = '$baseUrl/auth/google';
  static const String getPersonalInformation = '$baseUrl/users/profile/v2';
  static const String updatePersonalInformationProfileData =
      '$baseUrl/users/profile-info';
  static const String updatePersonalInformationProfileImage =
      '$baseUrl/users/profile-picture';

  static const String getHomeScreenTask = '$baseUrl/tasks/v2';

  static const String createPersonalTask = '$baseUrl/tasks/v2';
  static const String createCollaborativeTask = '$baseUrl/tasks/v2';
  static const String createSingleAssignmentTask = '$baseUrl/tasks/v2';
  static const String getSupportMode = '$baseUrl/users/support-mode';
  static const String updateSupportMode = '$baseUrl/users/support-mode';
  static const String getNotification = '$baseUrl/activitys/my';

  static String markSingleNotification(String notificationId) {
    return '$baseUrl/activitys/$notificationId/read';
  }

  static const String getNotificationStyle =
      '$baseUrl/users/notification-style';
  static const String updateNotificationStyle =
      '$baseUrl/users/notification-style';
  static const String getPreferredTime = '$baseUrl/users/preferred-time';

  static String getPrivacyPolicyTermsConditionsAboutUs(String type) {
    return '$baseUrl/settings?type=$type';
  }


  static String getTaskDetails(String taskId) {
    return '$baseUrl/tasks/$taskId';
  }

  static String taskStatusUpdate(String taskId) {
    return '$baseUrl/tasks/$taskId/status/v5';
  }

  static String taskStatusStart(String taskId) {
    return '$baseUrl/tasks/$taskId/status';
  }

  static String updateSubTaskStatus(String taskId, String subtaskId) {
    return '$baseUrl/sub-task-progress/$taskId/subtasks/$subtaskId/toggle-status';
  }

  static const String changePassword = '$baseUrl/auth/change-password';
  static const String logOut = '$baseUrl/auth/logout/v2';
  static const String deleteAccount = '$baseUrl/users/delete-my-account';

  ///-------------------
  ///--- UGC -----------
  ///-------------------
  static const String getUgcDailyProgress = '$baseUrl/tasks/daily-progress/v3';

  // static const String getUgcHomeScreenTask = '$baseUrl/tasks?page=1&limit=10';
  static const String getUgcHomeScreenTask = '$baseUrl/tasks/v2';

  static String getUgcTaskDetails(String taskId) {
    return '$baseUrl/tasks/$taskId';
  }

  static String getIndividualTaskDetails(String taskId) {
    return '$baseUrl/tasks/$taskId';
  }

  static String getMemberList =
      '$baseUrl/children-business-users/my-family-members';

  static String ugcTaskStatusUpdate(String taskId) {
    return '$baseUrl/tasks/$taskId/status/v5';
  }

  static String ugcPersonalTaskStatusUpdate(String taskId) {
    return '$baseUrl/tasks/$taskId/status/v5';
  }

  static String editTask(String taskId) {
    return '$baseUrl/tasks/$taskId/v2';
  }

  static String deleteTask(String taskId) {
    return '$baseUrl/tasks/$taskId';
  }

  static String getTaskStatusList({
    required String taskStatus,
    String? fromDate,
    String? toDate,
  }) {
    String url = '$baseUrl/tasks?status=$taskStatus';

    if (fromDate != null && fromDate.isNotEmpty) {
      url = '$url&from=$fromDate';
    }

    if (toDate != null && toDate.isNotEmpty) {
      url = '$url&to=$toDate';
    }

    return url;
  }

  ///-------------------
  ///--- Individual ----
  ///-------------------


  static const String getUserIndividualTaskHistory = '$baseUrl/tasks/history';
  static const String getSubscription = '$baseUrl/subscription-plan/paginate?isActive=true&subscriptionType=individual';

  static String getSubscriptionRevenuecat(String subscriptionId) {
    return '$baseUrl/subscription-plan/revenuecat-purchase/$subscriptionId';
  }


}
