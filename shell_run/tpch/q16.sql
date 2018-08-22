 
SELECT
  p.brand,
  p.type,
  p.size,
  count(DISTINCT ps.suppkey) AS supplier_cnt
FROM
  "hive"."tpch_300gb_orc"."partsupp" AS ps,
  "hive"."tpch_300gb_orc"."part" AS p
WHERE
  p.partkey = ps.partkey
  AND p.brand <> 'Brand#45'
  AND p.type NOT LIKE 'MEDIUM POLISHED%'
  AND p.size IN (49, 14, 23, 45, 19, 3, 36, 9)
  AND ps.suppkey NOT IN (
    SELECT s.suppkey
    FROM
      "hive"."tpch_300gb_orc"."supplier" AS s
    WHERE
      s.comment LIKE '%Customer%Complaints%'
  )
GROUP BY
  p.brand,
  p.type,
  p.size
ORDER BY
  supplier_cnt DESC,
  p.brand,
  p.type,
  p.size
;
