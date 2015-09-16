#!/bin/bash
for (( i = 0; i < ${COUNT}; i++ )); do
  touch /logs/sample$i.out
	touch /logs/sample.err
	if [ "$BENCH" = "ab1" ]; then
		ab -c ${CL} -n ${NR} -k -e /logs/sample$i.csv http://${HOST}:${PORT}/${WEBSITE} > /logs/sample$i.out 2>>/logs/sample.err
	elif [ "$BENCH" = "ab2" ]; then
		ab -c ${CL} -n ${NR} -e /logs/sample$i.csv http://${HOST}:${PORT}/${WEBSITE} > /logs/sample$i.out 2>>/logs/sample.err
  elif [ "$BENCH" = "siege" ]; then
    siege -d${DELAY} -t${TIME}s -c${CL} http://${HOST}:${PORT}/${WEBSITE} >> /logs/sample.err 2>> /logs/sample$i.out
	elif [ "$BENCH" = "mysql1" ]; then
	    sysbench --test=oltp --mysql-host=${HOST} \
	    --mysql-port=${PORT} --oltp-table-size=${SIZE} \
	    --mysql-db=test --mysql-user=admin --mysql-password=test1234 \
	    --max-time=${TIME} --max-requests=0 --oltp-read-only=on --oltp-user-delay-min=${DELAY}  \
	    --num-threads=${THREADS} run > /logs/sample$i.out 2>>/logs/sample.err
  elif [ "$BENCH" = "mysql2" ]; then
	    sysbench --test=oltp --mysql-host=${HOST} \
	    --mysql-port=${PORT} --oltp-table-size=${SIZE} \
	    --mysql-db=test --mysql-user=admin --mysql-password=test1234 --max-requests=0 \
	    --max-time=${TIME} --oltp-read-only=off --oltp-user-delay-min=${DELAY}  \
	    --num-threads=${THREADS} run > /logs/sample$i.out 2>>/logs/sample.err
	elif [ "$BENCH" = "mysql3" ]; then
		    sysbench --test=oltp --mysql-host=${HOST} \
		    --mysql-port=${PORT} --oltp-table-size=${SIZE} \
		    --mysql-db=test${PORT} --mysql-user=root \
		    --max-time=${TIME} --oltp-read-only=on --max-requests=${REQUESTS}  \
		    --num-threads=${THREADS} run > /logs/sample$i.out 2>>/logs/sample.err
  elif [ "$BENCH" = "mysql4" ]; then
		    sysbench --test=oltp --mysql-host=${HOST} \
		    --mysql-port=${PORT} --oltp-table-size=${SIZE} \
		    --mysql-db=test${PORT} --mysql-user=root \
		    --max-time=${TIME} --oltp-read-only=off --max-requests=${REQUESTS}  \
		    --num-threads=8 run > /logs/sample$i.out 2>>/logs/sample.err
	elif [ "$BENCH" = "cpu" ]; then
	    sysbench --test=cpu --cpu-max-prime=${SIZE} --num-threads=8 \
	    run > /logs/sample$i.out 2>>/logs/sample.err
	elif [ "$BENCH" = "dacapo" ]; then
		cat /xaa /xab > /dacapo.jar
		java -jar /dacapo.jar ${CMD} >> /logs/sample$i.out 2>> /logs/sample$i.out
	elif [ "$BENCH" = "io1" ]; then
		sysbench --test=fileio \
		--file-test-mode=rndrd --init-rng=on \
		run > /logs/sample.out 2>>/logs/sample.err
	elif [ "$BENCH" = "io2" ]; then
		sysbench --test=fileio \
		--file-test-mode=rndwr --init-rng=on \
		run > /logs/sample.out 2>>/logs/sample.err
	fi
  cat /logs/sample$i.out
done
