 
SELECT
  s.acctbal,
  s.name,
  n.name,
  p.partkey,
  p.mfgr,
  s.address,
  s.phone,
  s.comment
FROM
  "hive"."tpch_300gb_orc"."part" p,
  "hive"."tpch_300gb_orc"."supplier" s,
  "hive"."tpch_300gb_orc"."partsupp" ps,
  "hive"."tpch_300gb_orc"."nation" n,
  "hive"."tpch_300gb_orc"."region" r
WHERE
  p.partkey = ps.partkey
  AND s.suppkey = ps.suppkey
  AND p.size = 15
  AND p.type like '%BRASS'
  AND s.nationkey = n.nationkey
  AND n.regionkey = r.regionkey
  AND r.name = 'EUROPE'
  AND ps.supplycost = (
    SELECT
      min(ps.supplycost)
    FROM
      "hive"."tpch_300gb_orc"."partsupp" ps,
      "hive"."tpch_300gb_orc"."supplier" s,
      "hive"."tpch_300gb_orc"."nation" n,
      "hive"."tpch_300gb_orc"."region" r
    WHERE
      p.partkey = ps.partkey
      AND s.suppkey = ps.suppkey
      AND s.nationkey = n.nationkey
      AND n.regionkey = r.regionkey
      AND r.name = 'EUROPE'
  )
ORDER BY
  s.acctbal desc,
  n.name,
  s.name,
  p.partkey
;
