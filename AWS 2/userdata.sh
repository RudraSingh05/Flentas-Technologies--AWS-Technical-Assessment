#!/bin/bash
yum update -y
amazon-linux-extras install nginx1 -y
systemctl enable nginx
systemctl start nginx

# Create website folder
mkdir -p /usr/share/nginx/html

# Copy your resume (placed by TF)
cp /home/ec2-user/rudra_singh.pdf /usr/share/nginx/html/rudra_singh.pdf

# Create index.html
cat <<EOF > /usr/share/nginx/html/index.html
<html>
<head><title>Rudra Singh - Resume</title></head>
<body>
<h1>Resume</h1>
<p><a href="rudra_singh.pdf" download>Download My Resume</a></p>
</body>
</html>
EOF

systemctl restart nginx
