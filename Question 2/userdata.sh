#!/bin/bash
yum update -y
yum install -y nginx

systemctl enable nginx
systemctl start nginx

mkdir -p /usr/share/nginx/html

cp /home/ec2-user/rudra_singh.pdf /usr/share/nginx/html/rudra_singh.pdf

cat <<EOF > /usr/share/nginx/html/index.html
<html>
<head>
  <meta http-equiv="refresh" content="0; url=rudra_singh.pdf" />
</head>
<body>
  <p>If you're not redirected automatically, <a href="rudra_singh.pdf">click here</a>.</p>
</body>
</html>
EOF

systemctl restart nginx