# Example: download manually or via the script
./download_large_file.sh
git lfs track "Mod/ModPack.zip"
git add .gitattributes Mod/ModPack.zip
git commit -m "Update ModPack.zip"
git push
