BootStrap: docker
From: ubuntu:latest

%runscript
TEMPDIR="$(mktemp -d)"
echo "Creating and changing into temporary directory $TEMPDIR..."
cd "$TEMPDIR"

# Hard coded path for wineprefix
APPDIR="$HOME/WINE/Topofusion"
PROFILEDIR="$HOME/WINE/PROFILES/${USER}@${HOSTNAME}"
mkdir -p $APPDIR
mkdir -p $PROFILEDIR

echo "Setting up wine prefix..."
export WINEPREFIX="$TEMPDIR/wineprefix"
export WINEARCH="win32"

if [ -f "$APPDIR/wineprefix.tgz" ]; then
    echo "Found existing wineprefix - restoring it..."
    mkdir -p "$WINEPREFIX"
    cd "$WINEPREFIX"
    tar xzf "$APPDIR/wineprefix.tgz"
else
  wineboot --init

  echo "Installing TopoFusion and its dependencies ..."
  winetricks dlls directx9
  winetricks dlls vb6run
  wget http://topofusion.com/TopoFusion-Demo-Pro-5.43.exe
  wine ./TopoFusion-Demo-Pro-5.43.exe
fi

echo "Containerizing user profile..."
if [ -d "$PROFILEDIR" ]; then
    rm -rf "$WINEPREFIX/drive_c/users/$USER"
else
    echo "This user profile is newly generated..."
    mv "$WINEPREFIX/drive_c/users/$USER" "$PROFILEDIR"
fi
echo "Loading existing user profile"
ln -s "$PROFILEDIR" "$WINEPREFIX/drive_c/users/$USER"

# at first container start run bash to let user finish configuration
if [ ! -f "$APPDIR/wineprefix.tgz" ]; then
  env WINEPREFIX="$WINEPREFIX" WINEARCH="$WINEARCH" /bin/bash
fi

# run TopoFusion
    wine $WINEPREFIX/drive_c/Program\ Files/TopoFusion/TopoFusion.exe

if [ ! -f "$APPDIR/wineprefix.tgz" ]; then
 wineboot --end-session
 echo "Saving initial wineprefix..."
 cd $WINEPREFIX && tar czf "$APPDIR/wineprefix.tgz" . && sync
fi 

rm -rf "$TEMPDIR" 

%post
    dpkg --add-architecture i386 
    apt update
    apt -y install wget less vim software-properties-common python3-software-properties apt-transport-https winbind
    wget https://dl.winehq.org/wine-builds/Release.key
    apt-key add Release.key
    apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
    apt update
    apt install -y winehq-stable winetricks # this installs Wine2
    mkdir /APPS /PROFILES
    chmod 0777 /APPS /PROFILES

    mkdir /uufs /scratch
