class AppConstants {
  // API
  static const String baseUrl = 'https://theaudiodb.com/api/v1/json/523532';
  
  // Routes
  static const String homeRoute = '/';
  static const String artistRoute = '/artist/:id';
  static const String albumRoute = '/album/:id';
  
  // Storage Keys
  static const String favoriteArtistsKey = 'favorite_artists';
}

class ApiEndpoints {
  static const String searchArtist = '/search.php';
  static const String searchAlbum = '/searchalbum.php';
  static const String getArtistDetails = '/artist.php';
  static const String getAlbumDetails = '/album.php';
  static const String getAlbumsByArtist = '/album.php';
  static const String getTopSingles = '/trending.php';
  static const String getTopAlbums = '/trending.php';
}