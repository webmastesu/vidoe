import 'package:flutter/material.dart';
import '../models/manga.dart';
import '../models/download_link.dart';
import '../services/api_service.dart';
import '../video_player_page.dart';

class DetailPage extends StatelessWidget {
  final Manga manga;

  DetailPage({required this.manga});

  void _showDownloadLinks(BuildContext context) async {
    try {
      List<DownloadLink> downloadLinks = await ApiService.getDownloadLinks(int.parse(manga.id), 1);

      if (downloadLinks.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No download links available')));
        return;
      }

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ListView.builder(
            itemCount: downloadLinks.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => VideoPlayerPage(videoUrl: downloadLinks[index].url),
                    ));
                  },
                  child: Text('Server ${downloadLinks[index].linkOrder}'),
                ),
              );
            },
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load download links')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Image.network(
            manga.banner,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 250),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.0),
                      topRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              manga.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (manga.customTag != null)
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                manga.customTag!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '${manga.releaseDate}  |  ${_contentTypeToString(manga.contentType)}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        manga.description,
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: Icon(Icons.download),
                            onPressed: () {
                              _showDownloadLinks(context);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Genres: ${manga.genres.split(",").map((genre) => genre.trim()).join(", ")}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Downloadable: ${manga.downloadable ? "Yes" : "No"}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Status: ${_statusToString(manga.status)}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'ID: ${manga.id}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _contentTypeToString(int contentType) {
    switch (contentType) {
      case 1:
        return 'Movie';
      case 2:
        return 'Series';
      default:
        return 'Unknown';
    }
  }

  String _statusToString(int status) {
    switch (status) {
      case 1:
        return 'Ongoing';
      case 2:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }
}
