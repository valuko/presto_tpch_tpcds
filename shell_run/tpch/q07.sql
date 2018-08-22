 
SELECT
  supp_nation,
  cust_nation,
  l_year,
  sum(volume) AS revenue
FROM (
       SELECT
         n1.name                          AS supp_nation,
         n2.name                          AS cust_nation,
         extract(YEAR FROM l.shipdate)      AS l_year,
         l.extendedprice * (1 - l.discount) AS volume
       FROM
         "hive"."tpch_300gb_orc"."supplier" AS s,
         "hive"."tpch_300gb_orc"."lineitem" AS l,
         "hive"."tpch_300gb_orc"."orders" AS o,
         "hive"."tpch_300gb_orc"."customer" AS c,
         "hive"."tpch_300gb_orc"."nation" AS n1,
         "hive"."tpch_300gb_orc"."nation" AS n2
       WHERE
         s.suppkey = l.suppkey
         AND o.orderkey = l.orderkey
         AND c.custkey = o.custkey
         AND s.nationkey = n1.nationkey
         AND c.nationkey = n2.nationkey
         AND (
           (n1.name = 'FRANCE' AND n2.name = 'GERMANY')
           OR (n1.name = 'GERMANY' AND n2.name = 'FRANCE')
         )
         AND l.shipdate BETWEEN DATE '1995-01-01' AND DATE '1996-12-31'
     ) AS shipping
GROUP BY
  supp_nation,
  cust_nation,
  l_year
ORDER BY
  supp_nation,
  cust_nation,
  l_year
;
