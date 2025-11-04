# Social Media App

A new Flutter project for a social media application.

# Postly (Social Media)

Postly (previously the local "Social Media" project) is a Flutter social app built with a feature-based architecture. It demonstrates authentication, posting, profiles, and realtime-like updates using Firebase / Supabase.

This README summarizes how to set up, run, and troubleshoot the project locally and lists a few recent fixes and TODOs relevant to ongoing development.

## Quick Start (Windows / PowerShell)

1. Clone the repo (if you haven't already):

```powershell
git clone https://github.com/your-username/social_media.git
cd social_media
```

2. Install dependencies:

```powershell
flutter pub get
```

3. Run on a connected device or emulator:

```powershell
flutter run -d <device-id>
```

Replace `<device-id>` with `windows`, `chrome`, `emulator-5554`, or `device id` from `flutter devices`.

## Project layout

Key folders under `lib/`:

- `core/` — shared models, helpers, utilities, and app-wide resources
- `features/` — feature-scoped modules (authentication, home, profile, edit_profile, add_post, search)

The code uses BLoC (Cubit) for state management and `go_router` for navigation.

## Main dependencies

- flutter_bloc
- go_router
- firebase_core, firebase_auth, cloud_firestore, firebase_storage
- supabase_flutter (used for media storage)
- cached_network_image
- image_picker
- quickalert
- get_it, dartz, uuid, dio

See `pubspec.yaml` for exact versions.

## Configuration

- Firebase: Add your Firebase `google-services.json` (Android) and `GoogleService-Info.plist` (iOS / macOS) as appropriate. The repo already contains an `app/google-services.json` placeholder used in development.
- Supabase: Credentials are currently set in code (see `lib/firebase_options.dart` / `lib/main.dart`). For production, move keys to environment variables or a secure secrets manager and never check them into VCS.

## Recent fixes & behaviour notes

- Image caching: When users update their profile picture the app now evicts the old and new image URLs from `cached_network_image` cache so the new image appears immediately without a hot restart.
- Edit Profile: The edit flow shows a loading indicator during update and navigates back when complete. The Profile view listens for edit success and reloads the current user.
- Signup dialog: After successful registration the app pops back to the login screen and displays a success dialog there (avoids showing a dialog on a soon-to-be disposed context).
- Profile follow button: Fixed so tapping your own post to open the profile won't show a Follow button — the view correctly detects when the displayed profile equals the logged-in user.
- Null-safety: Defensive checks were added in post owner widgets to prevent `_TypeError (Null check operator used on a null value)` when owner data is missing.

## How to test the main flows

- Sign up / Login: Use the register screen to create an account. After sign-up you'll be returned to login with a success dialog.
- Edit profile: Update name, username, bio, and profile image. The app shows a loading spinner during network operations and updates all screens on success.
- Posts: Create posts from the `Add Post` tab. Tap a post owner to go to their profile.

## Troubleshooting

- Build failures: Run `flutter clean` then `flutter pub get`, then re-run.
- Firebase issues: Confirm `google-services.json` and Firebase project configuration match your package name.
- Image not updating: If you still see an old profile image after changing it, try clearing app data or uninstalling in development. The code evicts cached URLs on edit; if your storage overwrites the same URL on the server, consider adding a timestamp query parameter when uploading to force a new URL.

## Development notes & TODOs

- Add end-to-end tests for sign-up / profile edit flows.
- Move secrets out of source code and into secure environment variables.
- Consider adding a cache-busting URL strategy at upload time (append ?t=timestamp) to avoid same-URL overwrites.

## Contributing

Contributions are welcome. Open issues or PRs for bugs and small enhancements. If you want me to apply the app name `Postly` across Android/iOS manifests and package IDs, tell me which level you want (display name only, or also package identifiers).

## Contact / Owner

Repo: https://github.com/your-username/social_media

---

If you'd like, I can also:
- Rename the app display name to `Postly` in Android/iOS
- Update `pubspec.yaml` metadata (project name and description)
- Rename the `widget_0616` file/class to `welcome_hero` and update imports

Tell me which of the above you want done next and I'll apply the changes.
