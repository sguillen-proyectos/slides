server {
  listen 8000 default_server;
  listen [::]:8000 default_server;

  root /var/www/html;

  server_name _;

  location / {
    try_files $uri $uri/ =404;
  }
}