import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/artist.dart';
import '../models/album.dart';
import '../models/track.dart';
import '../models/trending.dart';
import '../../config/constants.dart';

part 'audio_db_service.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class AudioDbService {
  factory AudioDbService(Dio dio, {String baseUrl}) = _AudioDbService;
  
  @GET(ApiEndpoints.searchArtist)
  Future<ArtistResponse> searchArtist({
    @Query('s') required String artistName,
  });
  
  @GET(ApiEndpoints.searchAlbum)
  Future<AlbumResponse> searchAlbum({
    @Query('s') required String albumName,
  });
  
  @GET(ApiEndpoints.getArtistDetails)
  Future<ArtistResponse> getArtistDetails({
    @Query('i') required String artistId,
  });
  
  @GET(ApiEndpoints.getAlbumDetails)
  Future<AlbumResponse> getAlbumDetails({
    @Query('i') required String albumId,
  });
  
  @GET(ApiEndpoints.getAlbumsByArtist)
  Future<AlbumResponse> getAlbumsByArtist({
    @Query('i') required String artistId,
  });
  
  @GET('/track.php')
  Future<TrackResponse> getTracksByAlbum({
    @Query('m') required String albumId,
  });
  
  @GET(ApiEndpoints.getTopSingles)
  Future<TrendingResponse> getTopSingles({
    @Query('country') String country = 'us',
    @Query('type') String type = 'itunes',
    @Query('format') String format = 'singles',
  });
  
  @GET(ApiEndpoints.getTopAlbums)
  Future<TrendingResponse> getTopAlbums({
    @Query('country') String country = 'us',
    @Query('type') String type = 'itunes',
    @Query('format') String format = 'albums',
  });
}