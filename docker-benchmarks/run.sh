#!/bin/bash
for (( i = 0; i < ${COUNT}; i++ )); do
	if [ "$BENCH" = "ab1" ]; then
		echo ${HOST} >> /logs/sample.err
		echo ${PORT} >> /logs/sample.err
		echo ${WEBSITE} >> /logs/sample.err
	    ab -c ${CL} -n ${NR} -k -e /logs/sample.csv http://${HOST}:${PORT}/${WEBSITE} > /logs/sample.out 2>>/logs/sample.err
	elif [ "$BENCH" = "ab2" ]; then
		echo ${HOST} >> /logs/sample.err
		echo ${PORT} >> /logs/sample.err
		echo ${WEBSITE} >> /logs/sample.err
	    ab -c ${CL} -n ${NR} -e /logs/sample.csv http://${HOST}:${PORT}/${WEBSITE} > /logs/sample.out 2>>/logs/sample.err
	elif [ "$BENCH" = "mysql1" ]; then
	    sysbench --test=oltp --mysql-host=${HOST} \
	    --mysql-port=${PORT} --oltp-table-size=${SIZE} \
	    --mysql-db=test --mysql-user=admin --mysql-password=test1234 \
	    --max-time=${TIME} --oltp-read-only=on --max-requests=${REQUESTS}  \
	    --num-threads=${THREADS} run > /logs/sample.out 2>>/logs/sample.err
	    cat /logs/sample.*
    elif [ "$BENCH" = "mysql2" ]; then
	    sysbench --test=oltp --mysql-host=${HOST} \
	    --mysql-port=${PORT} --oltp-table-size=${SIZE} \
	    --mysql-db=test --mysql-user=admin --mysql-password=test1234 \
	    --max-time=${TIME} --oltp-read-only=off --max-requests=${REQUESTS}  \
	    --num-threads=8 run > /logs/sample.out 2>>/logs/sample.err
	    cat /logs/sample.*
	elif [ "$BENCH" = "cpu" ]; then
	    sysbench --test=cpu --cpu-max-prime=${SIZE} --num-threads=8 \
	    run > /logs/sample.out 2>>/logs/sample.err
	elif [ "$BENCH" = "dacapo" ]; then
		cat /xaa /xab > /dacapo.jar
		java -jar /dacapo.jar ${CMD} > /logs/sample.out 2>>/logs/sample.err
	elif [ "$BENCH" = "io1" ]; then
		sysbench --test=fileio \
		--file-test-mode=rndrd --init-rng=on \
		run > /logs/sample.out 2>>/logs/sample.err
	elif [ "$BENCH" = "io2" ]; then
		sysbench --test=fileio \
		--file-test-mode=rndwr --init-rng=on \
		run > /logs/sample.out 2>>/logs/sample.err
	fi
done
