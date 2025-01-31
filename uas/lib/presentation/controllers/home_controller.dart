import '../../domain/usecases/navigate_to_page.dart';

class HomeController {
  final NavigateToPageUseCase _navigateToPageUseCase;

  HomeController(this._navigateToPageUseCase);

  void onBottomNavTapped(int index) {
    _navigateToPageUseCase.execute(index); // Navigate to the selected page
  }
}
