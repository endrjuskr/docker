#!/bin/bash
for (( i = 0; i < ${COUNT}; i++ )); do
        rm -f /logs/sample.csv /logs/sample.out
	if [ "$BENCH" = "ab1" ]; then
	    ab -c ${CL} -n ${NR} -k -e /logs/sample.csv ${HOST}/${WEBSITE} >> /logs/sample.out
	elif [ "$BENCH" = "ab2" ]; then
	    ab -c ${CL} -n ${NR} -e /logs/sample.csv ${HOST}/${WEBSITE} >> /logs/sample.out
	elif [ "$BENCH" = "mysql1" ]; then
	    sysbench --test=oltp --mysql-host=${HOST} \
	    --mysql-port=${PORT} --oltp-table-size=${SIZE} \
	    --mysql-db=test --mysql-user=admin --mysql-password=test1234 \
	    --max-time=${TIME} --oltp-read-only=on --max-requests=${REQUESTS}  \
	    --num-threads=${THREADS} run >> /logs/sample.out
    elif [ "$BENCH" = "mysql2" ]; then
	    sysbench --test=oltp --mysql-host=${HOST} \
	    --mysql-port=${PORT} --oltp-table-size=${SIZE} \
	    --mysql-db=test --mysql-user=admin --mysql-password=test1234 \
	    --max-time=${TIME} --oltp-read-only=off --max-requests=${REQUESTS}  \
	    --num-threads=${THREADS} run >> /logs/sample.out
	elif [ "$BENCH" = "cpu" ]; then
	    sysbench --test=cpu --cpu-max-prime=${SIZE} \
	    run >> /logs/sample.out
	elif [ "$BENCH" = "dacapo" ]; then
		cat /xaa /xab > /dacapo.jar
		java -jar /dacapo.jar ${CMD} >> /logs/sample.out
	elif [ "$BENCH" = "io" ]; then
		sysbench --test=fileio --file-total-size=${SIZE} \
		--file-test-mode=${READONLY} --init-rng=on --max-time=${TIME} \
		--max-requests=${REQUESTS} run >> /logs/sample.out
	fi
done
