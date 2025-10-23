import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final SupabaseClient _supabase = Supabase.instance.client;

  // Sign up with email and password
  static Future<AuthResponse> signUpWithEmail(
    String email,
    String password,
    String username,
  ) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'username': username,
        },
        emailRedirectTo: null, // Disable email redirect
      );

      // If user is created but email is not confirmed, try to confirm it manually
      if (response.user != null && response.user!.emailConfirmedAt == null) {
        print('User created but email not confirmed, attempting manual confirmation...');
        // Try to sign in immediately to trigger confirmation
        try {
          await _supabase.auth.signInWithPassword(
            email: email,
            password: password,
          );
          print('User signed in successfully after registration');
        } catch (signInError) {
          print('Could not sign in after registration: $signInError');
        }
      }

      if (response.user != null) {
        print('User registered successfully: ${response.user!.email}');
        
        // Try to create user profile manually if trigger doesn't work
        try {
          await _supabase.from('users').insert({
            'id': response.user!.id,
            'email': email,
            'username': username,
          });
          print('User profile created successfully');
        } catch (profileError) {
          print('Warning: Could not create user profile: $profileError');
          // Don't throw error here, user is still registered
        }
      }

      return response;
    } catch (error) {
      print('Signup error details: $error');
      throw Exception('Failed to sign up: $error');
    }
  }

  // Sign in with email and password
  static Future<AuthResponse> signInWithEmail(
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (error) {
      throw Exception('Failed to sign in: $error');
    }
  }

  // Sign out
  static Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (error) {
      throw Exception('Failed to sign out: $error');
    }
  }

  // Get current user
  static User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  // Check if user is authenticated
  static bool isAuthenticated() {
    return _supabase.auth.currentUser != null;
  }

  // Listen to auth state changes
  static Stream<AuthState> get authStateChanges {
    return _supabase.auth.onAuthStateChange;
  }

  // Get user profile from users table
  static Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      final user = getCurrentUser();
      if (user == null) return null;

      final response = await _supabase
          .from('users')
          .select('*')
          .eq('id', user.id)
          .single();

      return response;
    } catch (error) {
      print('Error fetching user profile: $error');
      return null;
    }
  }

  // Update user profile
  static Future<void> updateUserProfile({
    String? username,
    String? fullName,
    String? avatarUrl,
  }) async {
    try {
      final user = getCurrentUser();
      if (user == null) throw Exception('User not authenticated');

      final updateData = <String, dynamic>{};
      if (username != null) updateData['username'] = username;
      if (fullName != null) updateData['full_name'] = fullName;
      if (avatarUrl != null) updateData['avatar_url'] = avatarUrl;

      await _supabase
          .from('users')
          .update(updateData)
          .eq('id', user.id);
    } catch (error) {
      throw Exception('Failed to update profile: $error');
    }
  }
}
