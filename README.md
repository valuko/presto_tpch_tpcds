# Presto TPC-H and TPC-DS Benchmarks
Source code for TPC-H and TPC-DS Benchmarks on PrestoDB. The benchmark can be executed using BenchTo or using shell script to run it

## Setup Guide

- Install PrestoDB BenchTo Service
- Download the executable jar: https://drive.google.com/open?id=1_IVBO2vfJZE5l2ATGDVWeCqoE3sFpeMQ 

### Schema creation
- Run `./generate_schemas/generate-tpc*.sh` to generate the SQL for creating the appropriate schema for the benchmarks
- Run the generated SQL statements through the appropriate presto shell

## Usage

### BenchTo Guide
- Use the executable jar to run the BenchTo benchmark
- Follow the guide in Presto_README.md

### Shell script
- Modify `./shell_run/runlist_tpc*.pl` with the appropriate presto path and coordinator server name
- Run `./shell_run/runlist_tpch.pl` to run the TPC-H benchmark 
- Run `./shell_run/runlist_tpcds.pl` to run the TPC-DS benchmark 
