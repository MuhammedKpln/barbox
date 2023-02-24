flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs --release
flutter build macos --release
rm Spamify.dmg
{
    appdmg ./config.json ./Spamify.dmg
} || {
    echo "appdmg is not installed. Please install it and try again."
    exit 1
}
