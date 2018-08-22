 
SELECT
  nation,
  o_year,
  sum(amount) AS sum_profit
FROM (
       SELECT
         n.name                                                          AS nation,
         extract(YEAR FROM o.orderdate)                                  AS o_year,
         l.extendedprice * (1 - l.discount) - ps.supplycost * l.quantity AS amount
       FROM
         "hive"."tpch_300gb_orc"."part" AS p,
         "hive"."tpch_300gb_orc"."supplier" AS s,
         "hive"."tpch_300gb_orc"."lineitem" AS l,
         "hive"."tpch_300gb_orc"."partsupp" AS ps,
         "hive"."tpch_300gb_orc"."orders" AS o,
         "hive"."tpch_300gb_orc"."nation" AS n
       WHERE
         s.suppkey = l.suppkey
         AND ps.suppkey = l.suppkey
         AND ps.partkey = l.partkey
         AND p.partkey = l.partkey
         AND o.orderkey = l.orderkey
         AND s.nationkey = n.nationkey
         AND p.name LIKE '%green%'
     ) AS profit
GROUP BY
  nation,
  o_year
ORDER BY
  nation,
  o_year DESC
;
