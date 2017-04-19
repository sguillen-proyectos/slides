upstream nodos  {
  server {{server1}}:8000;
  server {{server2}}:8000;
  server {{server3}}:8000;
}
server {
  listen 80 default_server;
  listen [::]:80 default_server;

  root /var/www/html;

  server_name _;

  location / {
    proxy_pass  http://nodos;
  }
}
