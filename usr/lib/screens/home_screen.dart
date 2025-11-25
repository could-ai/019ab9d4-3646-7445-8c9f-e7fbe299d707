import 'package:flutter/material.dart';
import '../models/habit.dart';
import '../widgets/habit_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock Data for the prototype
  final List<Habit> _habits = [
    Habit(
      id: '1',
      title: 'Morning Meditation',
      emoji: '🧘‍♀️',
      note: 'Focus on breath for 10 mins',
      createdAt: DateTime.now(),
    ),
    Habit(
      id: '2',
      title: 'Drink Water',
      emoji: '💧',
      note: '2 liters goal',
      createdAt: DateTime.now(),
    ),
    Habit(
      id: '3',
      title: 'Read a Book',
      emoji: '📖',
      note: 'Currently reading: Atomic Habits',
      createdAt: DateTime.now(),
    ),
    Habit(
      id: '4',
      title: 'Evening Walk',
      emoji: '🌙',
      note: 'No phone, just walking',
      createdAt: DateTime.now(),
    ),
  ];

  void _toggleHabit(int index) {
    setState(() {
      _habits[index].isCompleted = !_habits[index].isCompleted;
    });
  }

  void _addNewHabit(String title, String emoji) {
    setState(() {
      _habits.add(Habit(
        id: DateTime.now().toString(),
        title: title,
        emoji: emoji,
        createdAt: DateTime.now(),
      ));
    });
    Navigator.pop(context);
  }

  void _showAddHabitSheet() {
    String newTitle = '';
    String selectedEmoji = '✨';
    
    final List<String> commonEmojis = ['✨', '🏃', '💧', '🧘', '📖', '🥗', '💤', '🎨', '🌿', '💊'];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF262626),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "New Intention",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "What would you like to do?",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.black.withOpacity(0.2),
              ),
              onChanged: (value) => newTitle = value,
            ),
            const SizedBox(height: 20),
            const Text(
              "Choose an Icon",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: commonEmojis.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // In a real app, we'd update state here to show selection
                      selectedEmoji = commonEmojis[index];
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        commonEmojis[index],
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (newTitle.isNotEmpty) {
                    _addNewHabit(newTitle, selectedEmoji);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF8E97FD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Begin Habit",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get current date for the header
    final now = DateTime.now();
    final dateStr = "${now.day}/${now.month}";
    
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today, $dateStr",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF8E97FD), // Periwinkle accent
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Your Daily Journal",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),

            // Habits List
            Expanded(
              child: _habits.isEmpty
                  ? Center(
                      child: Text(
                        "No habits yet.\nAdd one to start your journey.",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: _habits.length,
                      itemBuilder: (context, index) {
                        return HabitCard(
                          habit: _habits[index],
                          onTap: () => _toggleHabit(index),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHabitSheet,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
