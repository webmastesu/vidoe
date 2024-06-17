import 'package:flutter/material.dart';
import '../models/manga.dart';
import '../services/api_service.dart';
import 'detail_page.dart'; // Import the detail page

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Manga>> futureManga;

  @override
  void initState() {
    super.initState();
    futureManga = ApiService.getAllMovies();
  }

  Future<void> _refreshMangaList() async {
    setState(() {
      futureManga = ApiService.getAllMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manga Reader'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshMangaList,
        child: FutureBuilder<List<Manga>>(
          future: futureManga,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No manga found'));
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  childAspectRatio: 0.65, // Adjust aspect ratio as needed
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final manga = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(manga: manga),
                        ),
                      );
                    },
                    child: MangaCard(manga: manga),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class MangaCard extends StatelessWidget {
  final Manga manga;

  const MangaCard({
    Key? key,
    required this.manga,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              manga.poster,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 50, // Fixed height for the overlay
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
              ),
              child: Text(
                manga.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1, // Ensure text stays on one line
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
