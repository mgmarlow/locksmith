# This script follows the LOVE distribution guidelines:
# https://love2d.org/wiki/Game_Distribution

$filename = "my_project"

Remove-Item ./build/ -Recurse
mkdir ./build/

echo "Creating .love file ..."
Compress-Archive -Path * -DestinationPath "./build/$filename.zip"
Move-Item "./build/$filename.zip" "./build/$filename.love"

echo "Copying Love dependencies ..."
cp ($env:LOVEPATH + "\love.exe") ./build/
cp ($env:LOVEPATH + "\*.dll") ./build/
cp ($env:LOVEPATH + "\license.txt") ./build/

echo "Fusing build ..."
cd ./build/
cmd /c copy /b love.exe+"$filename.love" "$filename.exe"
cd ../

echo "Build finished."
