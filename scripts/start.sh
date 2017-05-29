cd ui && screen -S ui \
  -d ember s --environment=production --proxy=http://127.0.0.1:8080 \
  && cd ..

cd analysis && screen -S server \
  -d python3 scripts/server.py 8080 --db-conf=temp/consumer.json \
  && cd ..

