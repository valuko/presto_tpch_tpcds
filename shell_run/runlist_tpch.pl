#!/usr/bin/perl

use strict;
use warnings;
use File::Basename;

# GLOBALS
my $SCRIPT_NAME = basename( __FILE__ );
my $SCRIPT_PATH = dirname( __FILE__ );

chdir $SCRIPT_PATH;
chdir 'tpch';
my @queries = glob '*.sql';

for my $query ( @queries ) {
	my $warn_logfile = "$query.warn.log";
	my $logname = "$query.log";
	print "Warming Query : $query\n"; 
	my $warmStart = time();
	my $cmd="(/usr/local/presto/presto --server namenode1:8084 --catalog tpch -f ./$query) | tee  ../tpch_logs/$warn_logfile > /dev/null";
	my @warnoutput=`$cmd`;

	my $warmEnd = time();
	my $warmTime = $warmEnd - $warmStart ;
	print "Warmed Query : $query In $warmTime secs\n"; 

	print "Running Query : $query\n"; 
	my $runStart = time();
	my $cmd2="(/usr/local/presto/presto --server namenode1:8084 --catalog tpch -f ./$query) | tee  ../tpch_logs/$logname > /dev/null";
	my @runoutput=`$cmd2`;

	my $runEnd = time();
	my $runTime = $runEnd - $runStart ;
	print "$query Done in  $runTime secs\n"; 
} # end for