import 'package:flutter/foundation.dart';

class NavigationViewModel extends ChangeNotifier {
  int _currentTabIndex = 0;
  bool _isOnboarding = true; // Start with luxury onboarding tour
  bool _showConciergeSheet = false;
  bool _showLoungeQrSheet = false;

  int get currentTabIndex => _currentTabIndex;
  bool get isOnboarding => _isOnboarding;
  bool get showConciergeSheet => _showConciergeSheet;
  bool get showLoungeQrSheet => _showLoungeQrSheet;

  void setTab(int index) {
    if (_currentTabIndex != index) {
      _currentTabIndex = index;
      notifyListeners();
    }
  }

  void startOnboarding() {
    _isOnboarding = true;
    notifyListeners();
  }

  void completeOnboarding() {
    _isOnboarding = false;
    _currentTabIndex = 0; // Go to Explore
    notifyListeners();
  }

  void openConcierge() {
    _showConciergeSheet = true;
    notifyListeners();
  }

  void closeConcierge() {
    _showConciergeSheet = false;
    notifyListeners();
  }

  void openLoungeQr() {
    _showLoungeQrSheet = true;
    notifyListeners();
  }

  void closeLoungeQr() {
    _showLoungeQrSheet = false;
    notifyListeners();
  }
}
