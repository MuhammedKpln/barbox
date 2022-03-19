flutter build macos --release
rm Spamify.dmg
{
    appdmg ./config.json ./Spamify.dmg
} || {
    echo "appdmg is not installed. Please install it and try again."
    exit 1
}
