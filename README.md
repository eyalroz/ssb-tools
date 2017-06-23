# Star Schema Benchmark tools (for MonetDB)

This project facilitates work with the Star Schema Benchmark (SSB) on a DBMS (currently, [MonetDB](https://www.monetdb.org/)).

| Table of contents|
|:----------------|
| [What's actually in here?](#whats-in-it)<br>  [About the Star Schema Benchmark](#about-ssb)<br> [Requirements](#requirements)<br> [Getting started](#getting-started)<br>|

## <a name="whats-in-it">What's actually in here?</a>

The repository comprises:

* A script for generating the SSB data using a generation utility, creating a new database with the SSB schemata, and loading the generated data
* The set of benchmark queries (with correct query result files to be added) - both by query X.Y number and by increasing order as simple numbers
* A submodule link to the data generation utility, [ssb-dbgen](https://github.com/eyalroz/ssb-dbgen); it will be pulled together with this repository and you should be able to just use it with no setup (although it does have its own requirements, such as a C compiler)
* Miscellaneous additional potentially useful scripts and SQL queries.

This repository is inspired by similar efforts of mine for [TPC-H](https://github.com/eyalroz/tpch-tools) and for the [USDT-Ontime](https://github.com/eyalroz/tpch-tools) data set and sort-of-a benchmark.

Only MonetDB is supported as a DBMS right now, and I have no immediate plans to add support for another DBMS - but you're welcome to open an issue and ask for one, or better yet - submit a pull request. It's just some bash scripting after all.

## <a name="about-ssb">About the Star Schema Benchmark</a>

The Star Schema Benchmark is a modification of the [TPC-H benchmark](http://tpc.org/tpch/), which is the Transaction Processing Council's (older) benchmark for evaluating the performance of Database Management Systems (DBMSes) on analytic queries - that is, queries which do not modify the data.

The TPC-H has various known issues and deficiencies which are beyond the scope of this document. Researchers [Patrick O'Neil](http://www.cs.umb.edu/~poneil/), [Betty O'Neil](http://www.cs.umb.edu/~eoneil/) and [Xuedong Chen](https://www.linkedin.com/in/xuedong-chen-18414ba/), from the University of Massachusats Boston, proposed a modification of the TPC-H benchmark which addresses some of these shortcomings, in several papers, the latest and most relevant being [Star Schema Benchmark, Revision 3](http://www.cs.umb.edu/~poneil/StarSchemaB.PDF) published June 2009. One of the key features of the modifcation is the conversion of the [TPC-H schemata](http://kejser.org/wp-content/uploads/2014/06/image_thumb2.png) to Star Schemata ("Star Schema" is a misnomer), by some denormalizing as well as dropping some of the data; more details appear <a href="#difference-from-tpch">below</a> and even more details in the paper itself.

The benchmark was also accompanied by the initial versions of the code in this repository - a modified utility to generate schema data on which to run the benchmark.

For a recent discussion of the benchmark, you may wish to also read [A Review of Star Schema Benchmark](https://arxiv.org/pdf/1606.00295.pdf), by Jimi Sanchez.

## <a name="requirements"> Requirements

* Internet connection (specifically HTTP)
* The Bourne Again Shell - bash
* various typical Unix-ish command-line tools: unzip, wget, sed, echo and so on.
* MonetDB installed and able to run
* Enough disk space for the data you want

## <a name="getting-started"> Getting started

1. Make sure you have a MonetDB 'Database Farm' set up (see the [MonetDB tutorial](https://www.monetdb.org/Documentation/UserGuide/Tutorial) if you're not sure how to do that)
2. Invoke `scripts/setup-ssb-db` to create and populate DB with data from 2000 through 2008; the script's command-line options are as follows:
```
  Options:
    -r, --recreate              If the TPC-H database exists, recreate it, dropping
                                all existing data. (If this option is unset, the 
                                database must not already exist)
    -s, --scale-factor FACTOR   The amount of test data to generate, in GB
    -G, --use-generated         Use previously-generated table load files (in the
                                data generation directory instead of re-generating
                                them using the dbgen utility.
    -g, --dbgen-dir             Look for the TPC-H data generation utility in the
                                specified directory.
    -l, --log-file FILENAME     Name of the file to log output into
    -d, --db-name NAME          Name of the database holding TPC-H test data
                                within the DB farm
    -f, --db-farm PATH          Filesystem path for the root directory of the DB farm
                                with the generated DB
    -p, --port NUMBER           Network port on the local host, which the server
                                will related to the DB farm
    -D, --data-gen-dir PATH     directory in which to generate the TPC-H table data
    -k, --keep-raw-tables       Keep the raw data generated by the tool outside of
                                the DBMS
```
3. (May not yet be supported) Execute `scripts/run_benchmark_queries.sh -v` as a sanity check, to make sure you get results that look like the expected answer (you can also diff-compare the results you get with  `scripts/run_benchmark_queries.sh -w` to the reference results in `expected_results/`).

### Questions? Requests? Feedback? Bugs?

Feel free to [open an issue](https://github.com/eyalroz/usdt-ontime-tools/issues) or [write me](mailto:E.Rozenberg@cwi.nl).

