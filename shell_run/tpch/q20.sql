 
SELECT 
  s.name, 
  s.address 
FROM 
  "hive"."tpch_300gb_orc"."supplier" s,
  "hive"."tpch_300gb_orc"."nation" n
WHERE 
  s.suppkey IN (
    SELECT 
      ps.suppkey 
    FROM 
      "hive"."tpch_300gb_orc"."partsupp" ps
    WHERE 
      ps.partkey IN (
        SELECT 
          p.partkey 
        FROM 
          "hive"."tpch_300gb_orc"."part" p
        WHERE 
          p.name like 'forest%'
      ) 
      AND ps.availqty > (
        SELECT 
          0.5*sum(l.quantity) 
        FROM 
          "hive"."tpch_300gb_orc"."lineitem" l
        WHERE 
          l.partkey = ps.partkey 
          AND l.suppkey = ps.suppkey 
          AND l.shipdate >= date('1994-01-01')
          AND l.shipdate < date('1994-01-01') + interval '1' YEAR
      )
  )
  AND s.nationkey = n.nationkey 
  AND n.name = 'CANADA'
ORDER BY 
  s.name
;
