# AI Mobile App - Beautiful Authentication with Supabase

A stunning web-based authentication application with Supabase integration featuring modern login and registration pages with a minimalistic, contemporary design.

## Features

- 🔐 **Secure Authentication** - Email/password login and registration
- 🎨 **Modern UI/UX** - Beautiful, minimalistic design following current trends
- 📱 **Responsive Design** - Optimized for mobile devices
- ⚡ **Real-time Auth** - Powered by Supabase
- 🛡️ **Error Handling** - Comprehensive error handling with SnackBar notifications
- 🚀 **Smooth Navigation** - Seamless flow between authentication and home screens

## Screenshots

The app features:
- **Splash Screen** - Animated welcome screen with gradient background
- **Login Page** - Clean email/password login with modern form design
- **Register Page** - Username, email, and password registration
- **Home Page** - Welcome dashboard with user information and feature cards

## 🚀 Quick Start

### 1. Prerequisites
- Node.js (14 or higher)
- A Supabase account and project at [supabase.com](https://supabase.com)

### 2. Local Development Setup
```bash
# Install dependencies
npm install

# Start the development server
npm start

# Open your browser to http://localhost:3000
```

### 2. Supabase Setup

#### Create a new Supabase project:
1. Go to [supabase.com](https://supabase.com)
2. Create a new project
3. Note down your project URL and anon key

#### Database Setup:
Run this SQL in your Supabase SQL Editor to create the profiles table:

```sql
-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- Create profiles table
create table if not exists public.profiles (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid unique not null,
  email text unique,
  username text,
  created_at timestamp with time zone default timezone('utc', now()),
  updated_at timestamp with time zone default timezone('utc', now())
);

-- Create unique index
create unique index if not exists profiles_user_id_idx on public.profiles(user_id);

-- Enable Row Level Security
alter table public.profiles enable row level security;

-- Allow users to view their own profile
create policy "Users can view their own profile" 
  on public.profiles for select 
  using (auth.uid() = user_id);

-- Allow users to insert their own profile
create policy "Users can insert their own profile" 
  on public.profiles for insert 
  with check (auth.uid() = user_id);

-- Allow users to update their own profile
create policy "Users can update their own profile" 
  on public.profiles for update 
  using (auth.uid() = user_id);
```

### 3. Flutter Setup

#### Install dependencies:
```bash
flutter pub get
```

#### Configure Supabase:
1. Open `lib/main.dart`
2. Replace `YOUR_SUPABASE_URL` with your Supabase project URL
3. Replace `YOUR_SUPABASE_ANON_KEY` with your Supabase anon key

```dart
await Supabase.initialize(
  url: 'https://your-project.supabase.co',
  anonKey: 'your-anon-key',
);
```

### 4. Run the Application

```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── screens/
│   ├── splash_screen.dart   # Animated splash screen
│   ├── auth/
│   │   ├── login_page.dart  # Login page with email/password
│   │   └── register_page.dart # Registration page with username/email/password
│   └── home/
│       └── home_page.dart   # Main dashboard after login
└── services/
    └── auth_service.dart    # Supabase authentication service
```

## Dependencies

- `supabase_flutter: ^2.5.6` - Supabase Flutter client
- `google_fonts: ^6.2.1` - Beautiful typography
- `flutter_svg: ^2.0.10+1` - SVG support
- `cupertino_icons: ^1.0.2` - iOS-style icons

## Design Features

### Modern UI Elements:
- **Gradient Backgrounds** - Beautiful purple-to-indigo gradients
- **Rounded Corners** - 12px border radius for modern look
- **Soft Shadows** - Subtle elevation effects
- **Google Fonts** - Inter font family for clean typography
- **Material 3** - Latest Material Design principles

### Color Scheme:
- Primary: `#6366F1` (Indigo)
- Secondary: `#8B5CF6` (Purple)
- Background: `#F9FAFB` (Light Gray)
- Text: `#111827` (Dark Gray)

### Form Design:
- Floating labels
- Icon prefixes
- Password visibility toggles
- Real-time validation
- Error states with red borders
- Loading states with spinners

## Authentication Flow

1. **Splash Screen** - Checks authentication status
2. **Login/Register** - User authentication
3. **Home Page** - Protected dashboard
4. **Sign Out** - Returns to login screen

## Error Handling

- Form validation with helpful error messages
- Network error handling with SnackBar notifications
- Loading states during authentication
- Graceful error recovery

## Security Features

- Row Level Security (RLS) enabled
- User-specific data access policies
- Secure password requirements
- Email verification support

## Customization

### Colors:
Update the color scheme in `main.dart`:
```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: const Color(0xFF6366F1), // Change this color
  brightness: Brightness.light,
),
```

### Fonts:
Change the font family in `main.dart`:
```dart
textTheme: GoogleFonts.interTextTheme(), // Change to your preferred font
```

## Troubleshooting

### Common Issues:

1. **Supabase connection errors**: Verify your URL and anon key
2. **Database errors**: Ensure the profiles table is created correctly
3. **Build errors**: Run `flutter clean` and `flutter pub get`
4. **Authentication issues**: Check Supabase auth settings

### Debug Mode:
Enable debug mode in Supabase for detailed error messages.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For support, please open an issue in the repository or contact the development team.

---

**Built with ❤️ using Flutter and Supabase**