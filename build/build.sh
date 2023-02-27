
function print() {
    GREEN="\033[0;32m"
    BOLDGREEN="\e[1;32m"
    ENDCOLOR="\e[0m"

    printf "${BOLDGREEN}[BARBOX]${ENDCOLOR}${GREEN} $1${ENDCOLOR}\n"
}




print "clean: build runner cache"
(cd ../lib; flutter pub run build_runner clean)
print "build: build runner"
(cd ../lib; flutter pub run build_runner build --delete-conflicting-outputs --release)
print "build: release macos"
(cd ../lib; flutter build macos --release)

FILE=BarBox.dmg
if test -f "$FILE"; then
    print "clean: Old build removed"
    rm BarBox.dmg
fi



{
    print "run: appdmg"
    appdmg ./config.json ./BarBox.dmg
} || {
    print "appdmg is not installed. Please install it and try again."
    exit 1
}
