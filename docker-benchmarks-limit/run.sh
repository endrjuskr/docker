#!/bin/bash
for (( i = 0; i < ${COUNT}; i++ )); do
  if [ "$BENCH" = "cpu" ]; then
	    ./cpulimit/src/cpulimit -l ${CPULIMIT} sysbench --test=cpu --cpu-max-prime=${SIZE} --num-threads=8 \
	    run > /logs/sample$i.out 2>>/logs/sample.err
	elif [ "$BENCH" = "dacapo" ]; then
		./cpulimit/src/cpulimit -l ${CPULIMIT} java -jar /dacapo.jar ${CMD} >> /logs/sample$i.out 2>> /logs/sample$i.out
	fi
done
