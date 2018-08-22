 
SELECT 
  ps.partkey, 
  sum(ps.supplycost*ps.availqty) AS value
FROM 
  "hive"."tpch_300gb_orc"."partsupp" ps,
  "hive"."tpch_300gb_orc"."supplier" s,
  "hive"."tpch_300gb_orc"."nation" n
WHERE 
  ps.suppkey = s.suppkey 
  AND s.nationkey = n.nationkey 
  AND n.name = 'GERMANY'
GROUP BY 
  ps.partkey
HAVING 
  sum(ps.supplycost*ps.availqty) > (
    SELECT 
      sum(ps.supplycost*ps.availqty) * 0.0001000000
    FROM 
      "hive"."tpch_300gb_orc"."partsupp" ps,
      "hive"."tpch_300gb_orc"."supplier" s,
      "hive"."tpch_300gb_orc"."nation" n
    WHERE 
      ps.suppkey = s.suppkey 
      AND s.nationkey = n.nationkey 
      AND n.name = 'GERMANY'
  )
ORDER BY 
  value DESC
;
