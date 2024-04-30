import 'package:flutter/material.dart';
import '../services/team_services.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NBA Player stats'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: TeamService.getTeams(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            case ConnectionState.active:
            case ConnectionState.done:
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(snapshot.data![index].id.toString()),
                        ),
                        title: Text(snapshot.data?[index].abbreviation),
                        subtitle: Text(snapshot.data?[index].city),
                      ),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
