import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/habit.dart';
import '../widgets/habit_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock data for initial state
  final List<Habit> _habits = [
    Habit(id: '1', title: 'Morning Meditation', emoji: '🧘', isCompleted: true),
    Habit(id: '2', title: 'Drink Water', emoji: '💧', isCompleted: false),
    Habit(id: '3', title: 'Read 10 Pages', emoji: '📚', isCompleted: false),
    Habit(id: '4', title: 'Walk Outside', emoji: '🌿', isCompleted: false),
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
      ));
    });
  }

  void _showAddHabitDialog() {
    String newTitle = '';
    String newEmoji = '✨'; // Default emoji

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1C1C1E),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'New Entry',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'What do you want to track?',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                  border: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      newEmoji,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                ),
                onChanged: (value) => newTitle = value,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white.withOpacity(0.5)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (newTitle.isNotEmpty) {
                        _addNewHabit(newTitle, newEmoji);
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD0BCFF),
                      foregroundColor: const Color(0xFF1C1C1E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Save'),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateString = DateFormat('EEEE, d MMMM').format(now);

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Journal',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 16,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                dateString,
                style: const TextStyle(
                  color: Color(0xFFE0E0E0),
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  fontFamily: 'Serif', // Fallback to default serif if not available
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView.builder(
                  itemCount: _habits.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return HabitTile(
                      habit: _habits[index],
                      onToggle: () => _toggleHabit(index),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHabitDialog,
        backgroundColor: const Color(0xFF2C2C2E),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        child: const Icon(Icons.add, color: Color(0xFFE0E0E0)),
      ),
    );
  }
}
