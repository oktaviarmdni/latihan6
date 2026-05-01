import 'package:flutter/material.dart';

// MODEL DATA
class Pertemuan {
  final String title;
  final String subtitle;

  const Pertemuan({required this.title, required this.subtitle});
}

// HALAMAN DETAIL
class PertemuanPage extends StatelessWidget {
  final Pertemuan pertemuan;

  const PertemuanPage({super.key, required this.pertemuan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pertemuan.title),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Text(
          pertemuan.subtitle,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// HALAMAN LIST (INI YANG DIPANGGIL DI DASHBOARD)
class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  final List<Pertemuan> pertemuanList = const [
    Pertemuan(title: 'Pertemuan 1', subtitle: 'Pengenalan Android'),
    Pertemuan(title: 'Pertemuan 2', subtitle: 'Widget & Button'),
    Pertemuan(title: 'Pertemuan 3', subtitle: 'Activity & Intent'),
    Pertemuan(title: 'Pertemuan 4', subtitle: 'Toast & AlertDialog'),
    Pertemuan(title: 'Pertemuan 5', subtitle: 'ListView'),
    Pertemuan(title: 'Pertemuan 6', subtitle: 'Checkbox'),
    Pertemuan(title: 'Pertemuan 7', subtitle: 'Radio Button'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pertemuan 5"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: pertemuanList.length,
        itemBuilder: (context, index) {
          final item = pertemuanList[index];

          return Card(
            child: ListTile(
              leading: const Icon(Icons.list),
              title: Text(item.title),
              subtitle: Text(item.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PertemuanPage(pertemuan: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
