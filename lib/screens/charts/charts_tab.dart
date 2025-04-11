import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/charts/charts_bloc.dart';
import '../../config/theme.dart';
import '../../widgets/chart_item_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/loading_widget.dart';

class ChartsTab extends StatefulWidget {
  const ChartsTab({Key? key}) : super(key: key);

  @override
  State<ChartsTab> createState() => _ChartsTabState();
}

class _ChartsTabState extends State<ChartsTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Assurez-vous que les données sont chargées
    final chartsState = context.read<ChartsBloc>().state;
    if (chartsState.singlesStatus == ChartsStatus.initial) {
      context.read<ChartsBloc>().add(const LoadTopSingles());
    }
    if (chartsState.albumsStatus == ChartsStatus.initial) {
      context.read<ChartsBloc>().add(const LoadTopAlbums());
    }
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Classements',
          style: TextStyle(
            fontFamily: 'SFProDisplay',
            fontSize: 30,
            fontWeight: FontWeight.w900, // Black
            letterSpacing: -0.5,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Titres'),
            Tab(text: 'Albums'),
          ],
          labelStyle: const TextStyle(
            fontFamily: 'SFProText',
            fontWeight: FontWeight.w600, // SemiBold
            fontSize: 16,
            letterSpacing: -0.2,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'SFProText',
            fontWeight: FontWeight.w400, // Regular
            fontSize: 16,
            letterSpacing: -0.2,
          ),
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppTheme.accentColor,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3.0,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Singles Tab
          _buildSinglesTab(),
          
          // Albums Tab
          _buildAlbumsTab(),
        ],
      ),
    );
  }
  
  Widget _buildSinglesTab() {
    return BlocBuilder<ChartsBloc, ChartsState>(
      buildWhen: (previous, current) => 
          previous.singlesStatus != current.singlesStatus || 
          previous.singles != current.singles,
      builder: (context, state) {
        if (state.singlesStatus == ChartsStatus.loading) {
          return const LoadingWidget();
        } else if (state.singlesStatus == ChartsStatus.failure) {
          return AppErrorWidget(
            message: state.singlesError ?? 'Erreur lors du chargement des singles',
            onRetry: () {
              context.read<ChartsBloc>().add(const LoadTopSingles());
            },
          );
        } else if (state.singlesStatus == ChartsStatus.success) {
          if (state.singles == null || state.singles!.isEmpty) {
            return const Center(
              child: Text(
                'Aucun single trouvé',
                style: TextStyle(
                  fontFamily: 'SFProText',
                  fontSize: 16,
                ),
              ),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8.0),
            itemCount: state.singles!.length,
            itemBuilder: (context, index) {
              final item = state.singles![index];
              return ChartItemWidget(
                rank: index + 1,
                title: item.trackName ?? 'Titre inconnu',
                subtitle: item.artistName ?? 'Artiste inconnu',
                imageUrl: item.trackThumbUrl ?? item.artistThumbUrl ?? '',
                onTap: () {
                  if (item.artistId != null) {
                    context.go('/artist/${item.artistId}');
                  }
                },
              );
            },
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }
  
  Widget _buildAlbumsTab() {
    return BlocBuilder<ChartsBloc, ChartsState>(
      buildWhen: (previous, current) => 
          previous.albumsStatus != current.albumsStatus || 
          previous.albums != current.albums,
      builder: (context, state) {
        if (state.albumsStatus == ChartsStatus.loading) {
          return const LoadingWidget();
        } else if (state.albumsStatus == ChartsStatus.failure) {
          return AppErrorWidget(
            message: state.albumsError ?? 'Erreur lors du chargement des albums',
            onRetry: () {
              context.read<ChartsBloc>().add(const LoadTopAlbums());
            },
          );
        } else if (state.albumsStatus == ChartsStatus.success) {
          if (state.albums == null || state.albums!.isEmpty) {
            return const Center(
              child: Text(
                'Aucun album trouvé',
                style: TextStyle(
                  fontFamily: 'SFProText',
                  fontSize: 16,
                ),
              ),
            );
          }
          
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8.0),
            itemCount: state.albums!.length,
            itemBuilder: (context, index) {
              final item = state.albums![index];
              return ChartItemWidget(
                rank: index + 1,
                title: item.albumName ?? 'Album inconnu',
                subtitle: item.artistName ?? 'Artiste inconnu',
                imageUrl: item.albumThumbUrl ?? item.artistThumbUrl ?? '',
                onTap: () {
                  if (item.albumId != null) {
                    context.go('/album/${item.albumId}');
                  } else if (item.artistId != null) {
                    context.go('/artist/${item.artistId}');
                  }
                },
              );
            },
          );
        }
        
        return const SizedBox.shrink();
      },
    );
  }
}