docker-benchmarks
===================

Benchmarks Docker image


Currently available types of benchmarks:
---

* Apache2 (`ab1`)
* Apache2 with keep-alive (`ab2`)
* MySQL (`mysql`)
* IO ('io')
* CPU by calculating prime numbers ('cpu')
* dacapo, variaty of benchmarks ('dacapo')

Run:
---

```
	$ sudo docker run -e BENCH=ab1 -e CL=5 -e NR=1000 \
	                -e HOST=http://google.pl \
	                -e WEBSITE=index.html \ 
	                endrjuskr/benchmarks
```

Arguments to pass:
---

* `BENCH` - type of benchmark
* `CL` - concurrency level
* `NR` - number of requests
* `HOST` - client's hostname
* `PORT` - client's port
* `TIME` - benchmark time limit
* 'REQUESTS' - benchmark random requests limit
* 'SIZE' - benchmark size
* 'READONLY' - indicates if benchmark is read-only
* 'THREADS' - benchmark thread limit
* 'WEBSITE' - client's website address
* 'CMD' - benchmark command to execute
* 'COUNT' - number of consecutive benchmarks

Pull
----

```
	$ docker pull endrjuskr/benchmarks
```

