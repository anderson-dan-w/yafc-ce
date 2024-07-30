rm -rf Build

VERSION=$(ggrep -oPm1 "(?<=<AssemblyVersion>)[^<]+" Yafc/Yafc.csproj)
echo "Building YAFC version $VERSION..."

dotnet publish Yafc/Yafc.csproj -r win-x64 -c Release -o Build/Windows
dotnet publish Yafc/Yafc.csproj -r osx-x64 --self-contained false -c Release -o Build/OSX
dotnet publish Yafc/Yafc.csproj -r osx-arm64 --self-contained false -c Release -o Build/OSX-arm64

dotnet publish Yafc/Yafc.csproj -r linux-x64 --self-contained false -c Release -o Build/Linux

pushd Build

tar czf Yafc-CE-Linux-$VERSION.tar.gz Linux
tar czf Yafc-CE-OSX-intel-$VERSION.tar.gz OSX
tar czf Yafc-CE-OSX-arm64-$VERSION.tar.gz OSX-arm64
zip -r Yafc-CE-Windows-$VERSION.zip Windows

popd
