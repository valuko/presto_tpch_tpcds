 
SELECT
  c.name,
  c.custkey,
  o.orderkey,
  o.orderdate,
  o.totalprice,
  sum(l.quantity)
FROM
  "hive"."tpch_300gb_orc"."customer" AS c,
  "hive"."tpch_300gb_orc"."orders" AS o,
  "hive"."tpch_300gb_orc"."lineitem" AS l
WHERE
  o.orderkey IN (
    SELECT l.orderkey
    FROM
      "hive"."tpch_300gb_orc"."lineitem" AS l
    GROUP BY
      l.orderkey
    HAVING
      sum(l.quantity) > 300
  )
  AND c.custkey = o.custkey
  AND o.orderkey = l.orderkey
GROUP BY
  c.name,
  c.custkey,
  o.orderkey,
  o.orderdate,
  o.totalprice
ORDER BY
  o.totalprice DESC,
  o.orderdate
LIMIT 100
;
