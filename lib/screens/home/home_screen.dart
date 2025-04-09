import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../blocs/charts/charts_bloc.dart';
import '../../blocs/favorites/favorites_bloc.dart';
import '../../blocs/search/search_bloc.dart';
import '../charts/charts_tab.dart';
import '../search/search_tab.dart';
import '../favorites/favorites_tab.dart';
import '../../config/theme.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;

  const HomeScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
    
    // Load initial data
    context.read<ChartsBloc>().add(const LoadTopSingles());
    context.read<ChartsBloc>().add(const LoadTopAlbums());
    context.read<FavoritesBloc>().add(const LoadFavorites());
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(), // Disable swiping
          children: const [
            ChartsTab(),
            SearchTab(),
            FavoritesTab(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppTheme.dividerColor, width: 1.0),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _tabController.animateTo(index);
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/Accueil_classements.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  _currentIndex == 0 ? AppTheme.accentColor : AppTheme.secondaryTextColor,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Classements',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/Accueil_Recherche.svg',
                width: 24, 
                height: 24,
                colorFilter: ColorFilter.mode(
                  _currentIndex == 1 ? AppTheme.accentColor : AppTheme.secondaryTextColor,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Recherche',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/Accueil_Favoris.svg',
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  _currentIndex == 2 ? AppTheme.accentColor : AppTheme.secondaryTextColor,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Favoris',
            ),
          ],
        ),
      ),
    );
  }
}