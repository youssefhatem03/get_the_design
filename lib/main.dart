import 'package:flutter/material.dart';

class Pet {
  String petCategory;
  String petType;
  int petLoveCount;
  String petPic;

  Pet({
    required this.petCategory,
    required this.petType,
    required this.petLoveCount,
    required this.petPic,
  });
}

List<Pet> petList = [
  Pet(
    petCategory: 'Dog',
    petType: 'Golden',
    petLoveCount: 20,
    petPic: 'assets/images/dog1.png',
  ),
  Pet(
    petCategory: 'Labrador',
    petType: 'Golden',
    petLoveCount: 18,
    petPic: 'assets/images/dog2.png',
  ),
  Pet(
    petCategory: 'Dog',
    petType: 'Cardigan',
    petLoveCount: 12,
    petPic: 'assets/images/dog3.png',
  ),
  Pet(
    petCategory: 'Cat',
    petType: 'Street Cat',
    petLoveCount: 17,
    petPic: 'assets/images/cat1.png',
  ),
  Pet(
    petCategory: 'Cat',
    petType: 'White Cat',
    petLoveCount: 19,
    petPic: 'assets/images/cat2.png',
  ),
  Pet(
    petCategory: 'Cat',
    petType: 'Kitten',
    petLoveCount: 18,
    petPic: 'assets/images/cat3.png',
  ),
  Pet(
    petCategory: 'Bird',
    petType: 'House Bird',
    petLoveCount: 15,
    petPic: 'assets/images/bird1.png',
  ),
  Pet(
    petCategory: 'Bird',
    petType: 'Parrot',
    petLoveCount: 14,
    petPic: 'assets/images/bird2.png',
  ),
  Pet(
    petCategory: 'Bird',
    petType: 'Pink Bird',
    petLoveCount: 15,
    petPic: 'assets/images/bird3.png',
  ),
  Pet(
    petCategory: 'Bird',
    petType: 'Talking Parrot',
    petLoveCount: 17,
    petPic: 'assets/images/bird3.png',
  ),
  Pet(
    petCategory: 'Rat',
    petType: 'Hamster',
    petLoveCount: 9,
    petPic: 'assets/images/hamster1.png',
  ),
  Pet(
    petCategory: 'Rabbit',
    petType: 'Brown Rabbit',
    petLoveCount: 16,
    petPic: 'assets/images/rabbit1.png',
  ),
  Pet(
    petCategory: 'Rabbit',
    petType: 'Gray Rabbit',
    petLoveCount: 17,
    petPic: 'assets/images/rabbit2.png',
  ),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'BalsamiqSans',
        useMaterial3: true,
      ),
      home: const PetScreen(),
    );
  }
}

class PetScreen extends StatefulWidget {
  const PetScreen({super.key});

  @override
  _PetScreenState createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Pet> _filteredPets = petList;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterPets);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterPets);
    _searchController.dispose();
    super.dispose();
  }

  void _filterPets() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredPets = petList.where((pet) {
        return pet.petCategory.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDFE0DF),
        title: const Center(child: Text('Pet Market')),
      ),
      body: Column(
        children: [
          const SizedBox(height: 5),
          Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.search,
                  color: Colors.orange,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search by pet category',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFFDFE0DF),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _filteredPets.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            _filteredPets[index].petPic,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _filteredPets[index].petType,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                _filteredPets[index].petCategory,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/pawprintImg.png",
                                    scale: 4,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    ' Pet Love: ${_filteredPets[index].petLoveCount}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
