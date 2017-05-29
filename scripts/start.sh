#!/bin/bash
main() {
  local root=$(pwd)

  cd $root/analysis && screen -S server \
    -d -m python3 scripts/server.py 8080 --db-conf=temp/consumer.json \
    && cd ..

  cd $root/ui
  ember s \
    --environment=production \
    --proxy=http://127.0.0.1:8080 \
}

main $@

