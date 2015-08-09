docker-benchmarks
===================

Benchmarks Docker image


Currently available types of benchmarks:
---

* Apache2 with keep-alive (`ab1`)
* Apache2 (`ab2`)
* MySQL read-only (`mysql1`)
* MySQL (`mysql2`)
* IO read-only (`io1`)
* IO write-read (`io2`)
* CPU by calculating prime numbers (`cpu`)
* dacapo, variaty of benchmarks (`dacapo`)

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
* `REQUESTS` - benchmark random requests limit
* `SIZE` - benchmark size
* `READONLY` - indicates if benchmark is read-only
* `THREADS` - benchmark thread limit
* `WEBSITE` - client's website address
* `CMD` - benchmark command to execute. Possible options you can find [on project's site](http://www.dacapobench.org/benchmarks.html)
* `COUNT` - number of consecutive benchmarks

Pull
----

```
	$ docker pull endrjuskr/benchmarks
```

Supported `dacapo` tests
---
| Test name     | Description | Is supported? | 
| ------------- |:---------:|:-------------:|
| avrora | simulates a number of programs run on a grid of AVR microcontrollers | x |
| batik | produces a number of Scalable Vector Graphics (SVG) images based on the unit tests in Apache Batik | |
| eclipse | executes some of the (non-gui) jdt performance tests for the Eclipse IDE | x |
| fop | takes an XSL-FO file, parses it and formats it, generating a PDF file. | x |
| h2 | executes a JDBCbench-like in-memory benchmark, executing a number of transactions against a model of a banking application, replacing the hsqldb benchmark | x |
| jython | inteprets a the pybench Python benchmark | x |
| luindex | Uses lucene to indexes a set of documents; the works of Shakespeare and the King James Bible | x |
| lusearch | Uses lucene to do a text search of keywords over a corpus of data comprising the works of Shakespeare and the King James Bible | x |
| pmd | analyzes a set of Java classes for a range of source code problems | x |
| sunflow | renders a set of images using ray tracing | x |
| tomcat | runs a set of queries against a Tomcat server retrieving and verifying the resulting webpages | x |
| tradebeans | runs the daytrader benchmark via a Jave Beans to a GERONIMO backend with an in memory h2 as the underlying database | x |
| tradesoap | runs the daytrader benchmark via a SOAP to a GERONIMO backend with in memory h2 as the underlying database | x |
| xalan | transforms XML documents into HTML | x |

