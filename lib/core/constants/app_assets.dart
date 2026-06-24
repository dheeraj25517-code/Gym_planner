class AppAssets {
  AppAssets._(); // Private constructor to prevent instantiation

  // Base directory paths
  static const String _imagesPath = 'assets/images';
  static const String _iconsPath = 'assets/icons';

  // --- Core Dashboard & Navigation Graphics ---
  static const String logo = '$_imagesPath/gym_logo.png';
  static const String dashboardHero = '$_imagesPath/dashboard_hero.png';
  
  // --- Training Day Group Cover Illustrative Placeholders ---
  // If your design features unique visual background thumbnails for each muscle group card
  static const String chestCover = '$_imagesPath/chest_bg.png';
  static const String tricepsCover = '$_imagesPath/triceps_bg.png';
  static const String backCover = '$_imagesPath/back_bg.png';
  static const String bicepsCover = '$_imagesPath/biceps_bg.png';
  static const String forearmsCover = '$_imagesPath/forearms_bg.png';

  // --- Custom Design Vector Icon Paths ---
  static const String iconTimer = '$_iconsPath/ic_timer.svg';
  static const String iconHistory = '$_iconsPath/ic_history.svg';
  static const String iconProfile = '$_iconsPath/ic_profile.svg';
  static const String iconDumbbell = '$_iconsPath/ic_dumbbell.svg';
  static const String iconStarFilled = '$_iconsPath/ic_star_filled.svg';
  static const String iconStarOutline = '$_iconsPath/ic_star_outline.svg';
}