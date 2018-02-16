#!/bin/bash
MEMORY=`free | awk 'NR==2 {printf("%d", ($3/$2*100) > 75)}'`

if [ $MEMORY = 1 ]; then
  notify-send 'Memory Caution' 'メモリ使用量が75%を越えています' --icon=dialog-information
fi

free | awk 'NR==2 {printf("%.2f%(%.2fG/%.2fG)", $3/$2*100, $3/(1024*1024), $2/(1024*1024))}'
