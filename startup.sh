#!/bin/bash
apt-get update
apt-get install -y python3

cat << 'EOF' > /root/hello.py
print("Hello from separate file!")
EOF

python3 /root/hello.py
