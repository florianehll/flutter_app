import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  }
  
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Classements',
          style: AppTheme.headingStyle,
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Titres'),
            Tab(text: 'Albums'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Singles Tab
          BlocBuilder<ChartsBloc, ChartsState>(
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
                    child: Text('Aucun single trouvé'),
                  );
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemCount: state.singles!.length,
                  itemBuilder: (context, index) {
                    final item = state.singles![index];
                    return ChartItemWidget(
                      rank: index + 1,
                      title: item.trackName ?? '',
                      subtitle: item.artistName ?? '',
                      imageUrl: item.trackThumbUrl ?? item.artistThumbUrl ?? '',
                      onTap: () {
                        if (item.artistId != null) {
                          // Navigate to artist details
                          // Using GoRouter
                          // context.go('/artist/${item.artistId}');
                        }
                      },
                    );
                  },
                );
              }
              
              return const SizedBox.shrink();
            },
          ),
          
          // Albums Tab
          BlocBuilder<ChartsBloc, ChartsState>(
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
                    child: Text('Aucun album trouvé'),
                  );
                }
                
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemCount: state.albums!.length,
                  itemBuilder: (context, index) {
                    final item = state.albums![index];
                    return ChartItemWidget(
                      rank: index + 1,
                      title: item.albumName ?? '',
                      subtitle: item.artistName ?? '',
                      imageUrl: item.albumThumbUrl ?? item.artistThumbUrl ?? '',
                      onTap: () {
                        if (item.artistId != null) {
                          // Navigate to artist details
                          // Using GoRouter
                          // context.go('/artist/${item.artistId}');
                        }
                      },
                    );
                  },
                );
              }
              
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}