import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  final VoidCallback onToggle;

  const HabitTile({
    super.key,
    required this.habit,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2E), // Soft dark card color
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0xFF3A3A3C),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                habit.emoji,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                habit.title,
                style: TextStyle(
                  color: habit.isCompleted
                      ? Colors.white.withOpacity(0.4)
                      : const Color(0xFFE0E0E0),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  decoration: habit.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  decorationColor: Colors.white.withOpacity(0.4),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: habit.isCompleted
                    ? const Color(0xFF8E8E93) // Muted completion color
                    : Colors.transparent,
                border: Border.all(
                  color: habit.isCompleted
                      ? const Color(0xFF8E8E93)
                      : const Color(0xFF636366),
                  width: 2,
                ),
                shape: BoxShape.circle,
              ),
              child: habit.isCompleted
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
