if ! [ -d "/var/www/pterodactyl" ]; then
    exit
fi
if ! [ -x "$(command -v curl)" ]; then
    apt -y update
    apt install -y curl
fi
cd /var/www/pterodactyl/database/Seeders
mkdir temp
mv NestSeeder.php EggSeeder.php temp/
curl -Lo data.zip https://github.com/LoganClinez/Egg-Installer/releases/latest/download/data.zip
unzip -n data.zip
rm data.zip
php ../../artisan migrate --seed --force
mv temp/NestSeeder.php temp/EggSeeder.php .
rm -rf temp/
