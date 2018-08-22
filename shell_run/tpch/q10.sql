 
SELECT
  c.custkey,
  c.name,
  sum(l.extendedprice * (1 - l.discount)) AS revenue,
  c.acctbal,
  n.name,
  c.address,
  c.phone,
  c.comment
FROM
  "hive"."tpch_300gb_orc"."lineitem" AS l,
  "hive"."tpch_300gb_orc"."orders" AS o,
  "hive"."tpch_300gb_orc"."customer" AS c,
  "hive"."tpch_300gb_orc"."nation" AS n
WHERE
  c.custkey = o.custkey
  AND l.orderkey = o.orderkey
  AND o.orderdate >= DATE '1993-10-01'
  AND o.orderdate < DATE '1993-10-01' + INTERVAL '3' MONTH
  AND l.returnflag = 'R'
  AND c.nationkey = n.nationkey
GROUP BY
  c.custkey,
  c.name,
  c.acctbal,
  c.phone,
  n.name,
  c.address,
  c.comment
ORDER BY
  revenue DESC
LIMIT 20
;
