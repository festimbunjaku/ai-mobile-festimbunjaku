import 'package:supabase_flutter/supabase_flutter.dart';

class TasksService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  // Fetch all tasks
  static Future<List<Map<String, dynamic>>> fetchTasks() async {
    try {
      final response = await _supabase
          .from('tasks')
          .select('*')
          .order('created_at', ascending: false);
      
      return List<Map<String, dynamic>>.from(response);
    } catch (error) {
      throw Exception('Failed to fetch tasks: $error');
    }
  }

  // Add a new task
  static Future<Map<String, dynamic>> addTask(String title) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final response = await _supabase.from('tasks').insert({
        'user_id': user.id,
        'title': title,
        'is_done': false,
      }).select().single();
      
      return response;
    } catch (error) {
      throw Exception('Failed to add task: $error');
    }
  }

  // Toggle task completion status
  static Future<void> toggleTaskStatus(String taskId, bool isDone) async {
    try {
      await _supabase
          .from('tasks')
          .update({'is_done': !isDone})
          .eq('id', taskId);
    } catch (error) {
      throw Exception('Failed to update task: $error');
    }
  }

  // Delete a task
  static Future<void> deleteTask(String taskId) async {
    try {
      await _supabase.from('tasks').delete().eq('id', taskId);
    } catch (error) {
      throw Exception('Failed to delete task: $error');
    }
  }

  // Update task title
  static Future<void> updateTaskTitle(String taskId, String newTitle) async {
    try {
      await _supabase
          .from('tasks')
          .update({'title': newTitle})
          .eq('id', taskId);
    } catch (error) {
      throw Exception('Failed to update task title: $error');
    }
  }
}
