docker-benchmarks
===================

Benchmarks Docker image


Currently available types of benchmarks:
---

* apache benchmark (`ab1`)
* apache benchmark with keep-alive (`ab2`)
* sysbench for read-only MySQL (`mysql`)

Run:
---

```
	$ sudo docker run -e BENCH=ab1 -e CL=5 -e NR=1000 \
	                -e HOST=http://google.pl/index.html \ 
	                endrjuskr/benchmarks
```

Arguments to pass:
---

* `BENCH` - type of benchmark
* `CL` - concurrency level, used only in `ab`
* `NR` - number of requests, used only in `ab`
* `HOST` - host to benchmark, used only in `ab`
* `MHOST` - MySQL host, used only in `mysql`
* `MPORT` - MySQL port, used only in `mysql`
* `MTIME` - time for benchmark execution, used only in `mysql`

Pull
----

```
	$ docker pull endrjuskr/benchmarks
```

