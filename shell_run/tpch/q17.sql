 
SELECT 
  sum(l.extendedprice)/7.0 as avg_yearly 
FROM 
  "hive"."tpch_300gb_orc"."lineitem" l,
  "hive"."tpch_300gb_orc"."part" p
WHERE 
  p.partkey = l.partkey 
  AND p.brand = 'Brand#23' 
  AND p.container = 'MED BOX'
  AND l.quantity < (
    SELECT 
      0.2*avg(l.quantity) 
    FROM 
      "hive"."tpch_300gb_orc"."lineitem" l
    WHERE 
    l.partkey = p.partkey
  )
;
