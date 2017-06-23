#!/bin/bash
#
# Note: This is _not_ the proper way to perform the benchmark - some queries will be run with cold data, some with hot data,
# there are no repetitions etc. Use it to check you're getting sane results for all of the queries

query_dir="benchmark_queries"
result_dir="expected_results"
db_name="ssb-sf-1"
db_port=50000
hostname=localhost

function usage {
	AUTHOR="Eyal Rozenberg"
	CONTACT_EMAIL="E.Rozenberg@cwi.nl"
	echo "Usage: $0 [OPTIONS]..."
	echo "Run the benchmark queries on the USDT On-Time data (for 2000-2008) "
	echo "within a MonetDB database, and "
	echo 
	echo "Options:"
	echo "  -d, --db-name NAME          Name of the database holding on-time performance data"
	echo "  -H, --hostname NAME         Connect to a DB on the specified remote host"
	echo "  -p, --port NUMBER           Network port on which the MonetDB server is listening"
	echo "  -f, --result-format FORMAT  Specify an output format for MonetDB to use"
	echo "  -q, --query-path PATH       Relative or absolute path to the directory containing the"
	echo "                              benchmark queries"
	echo "  -r, --results-path PATH     Relative or absolute path to the directory into which"
	echo "                              to write query results files"
	echo "  -w, --write-results         Write query results to files corresponding to the different"
	echo "                              benchmark queries"
	echo "  -h, --help                  Print usage information"
	echo "  -v, --verbose               Be verbose about actions taken and current status"
	echo 
	echo "For questions and details, contact $AUTHOR <$CONTACT_EMAIL> (or just read the source)."
}


function die {
	echo $1 >&2   # error message to stderr 
	exit ${2:-1}  # default exit code is -1 but you can specify something else
}

function db_is_up {
        # This assumes the DB exists
        local db_name=$1
        status=$(monetdb -p $port status $db_name 2>/dev/null | tail -1 | sed -r 's/^'$db_name'\s*([^ ]*).*$/\1/;')
        [[ -n "$status" && $status == "R" ]] && return 0 || return 1
}


while [[ $# > 0 ]]; do
	option_key="$1"

	case $option_key in
	-h|--help)
		usage;
		exit;
		;;
	-w|--write-results)
		write_results=1
		;;
	-v|--verbose)
		be_verbose=1
		;;
	-r|--result-dir|--result-path|--results-dir|--results-path)
		result_dir="$2"
		shift # past argument
		;;
	-q|--query-dir|--query--path)
		query_dir="$2"
		shift # past argument
		;;
	-H|--hostname)
		hostname="$2"
		shift # past argument
		;;
	-d|--dbname|--db-name|--database-name)
		db_name="$2"
		shift # past argument
		;;
	-f|--format|--output-format|--query-output-format)
		format="$2"
		shift # past argument
		;;
	-p|--port|--dbfarm-port)
		db_port="$2"
		shift # past argument
		is_positive_int $db_port || die "Invalid DB farm port $db_port"
		;;
	*) # unknown option
		die "Uknown command line option $option_key"
		;;
	esac
	shift # past argument or value
done
if [[ $# > 0 ]]; then
	usage
	exit -1
fi

[[ "$write_results" ]] && format=${format:-csv+,} || format=${format:-sql}

# Command-line parsing complete

# Check for binaries

for binary in mclient; do
	[[ -n `which $binary` ]] || die "Missing MonetDB binary $binary"
done


mkdir -p "$result_dir"
ls $query_dir/*.sql | while read query_file; do
	query_name="$(basename ${query_file} .${query_file##*.})"
	[[ -r "$query_file" ]] || die "Can't read query file $query_file"
	query=$(cat $query_file) 
	if [[ "$write_results" ]]; then
		output_file="$result_dir/$query_name.ans"
		[[ "$be_verbose" ]] && echo "mclient -lsql -f $format -d $db_name -p $db_port -h $hostname -s \"$query\"  > \"$output_file\""
		mclient -lsql -f $format -d $db_name -p $db_port -h $hostname -s "$query" > $output_file
	else
		if ! db_is_up $db_name; then monetdb -p $db_port stop $db_name > /dev/null ;  fi
		monetdb -p $db_port start $db_name > /dev/null
		[[ "$be_verbose" ]] && echo "Query $query_name: $query"
		mclient -lsql -f $format -d $db_name -p $db_port -h $hostname -s "$query" 
		[[ "$be_verbose" ]] && echo 
	fi
done

