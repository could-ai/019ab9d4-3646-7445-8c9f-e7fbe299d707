import 'package:flutter/material.dart';
import '../models/habit.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onTap;

  const HabitCard({
    super.key,
    required this.habit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Determine colors based on completion status
    // If completed, we use a very subtle tint of the primary color, else the surface color
    final backgroundColor = habit.isCompleted 
        ? const Color(0xFF2D3142) // Slightly blue-ish grey when done
        : Theme.of(context).cardTheme.color;
    
    final contentOpacity = habit.isCompleted ? 0.5 : 1.0;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: habit.isCompleted 
                ? Colors.transparent 
                : Colors.white.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Emoji Container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text(
                habit.emoji,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white.withOpacity(contentOpacity),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    habit.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(contentOpacity),
                      decoration: habit.isCompleted ? TextDecoration.lineThrough : null,
                      decorationColor: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  if (habit.note != null && habit.note!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        habit.note!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(contentOpacity),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),

            // Checkbox indicator (Custom soft circle)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: habit.isCompleted 
                    ? const Color(0xFF96E6B3).withOpacity(0.8) // Muted Mint
                    : Colors.transparent,
                border: Border.all(
                  color: habit.isCompleted 
                      ? Colors.transparent 
                      : Colors.white.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: habit.isCompleted
                  ? const Icon(Icons.check, size: 16, color: Colors.black54)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
