# Деплой Unbox ASMR на VPS
# Запускать на VPS после входа по SSH
apt update
apt install -y nginx git certbot python3-certbot-nginx
mkdir -p /var/www/unbox-asmr
if [ -d /var/www/unbox-asmr/.git ]; then cd /var/www/unbox-asmr && git pull origin main; else git clone https://github.com/LIGI464/ASMR-Unbox.git /var/www/unbox-asmr; fi
cp /var/www/unbox-asmr/nginx.unboxasmr.online.conf /etc/nginx/sites-available/unboxasmr.online
ln -sf /etc/nginx/sites-available/unboxasmr.online /etc/nginx/sites-enabled/unboxasmr.online
rm -f /etc/nginx/sites-enabled/default
nginx -t && systemctl reload nginx
certbot --nginx -d unboxasmr.online -d www.unboxasmr.online
