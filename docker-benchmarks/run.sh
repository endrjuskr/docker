#!/bin/bash
echo $BENCH
if [ "$BENCH" = "ab1" ]; then
    ab -c ${CL} -n ${NR} -k -e /logs/sample.csv ${HOST} > /logs/sample.out
elif [ "$BENCH" = "ab2" ]; then
    ab -c ${CL} -n ${NR} -e /logs/sample.csv ${HOST} > /logs/sample.out
elif [ "$BENCH" = "mysql" ]; then
    sysbench --test=oltp --mysql-host=${MHOST} \
    --mysql-port=${MPORT} --oltp-table-size=1000000 \
    --mysql-db=test --mysql-user=admin --mysql-password=test1234 \
    --max-time=${MTIME} --oltp-read-only=on --max-requests=0  \
    --num-threads=8 run
elif [ "$BENCH" = "cpu" ]; then
    sysbench --test=cpu --cpu-max-prime=${CPRIME} run
elif [ "$BENCH" = "dacapo" ]; then
	java -jar /dacapo.jar ${DCMD}
fi
