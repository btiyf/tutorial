# 結合編
htmlファイルがあるフォルダ上で`docker run --name kondo-nginx -d -p 20092:80 -v .:/usr/share/nginx/html:ro nginx`

`daemon off;`セミコロン注意
