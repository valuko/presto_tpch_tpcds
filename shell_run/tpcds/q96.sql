 
SELECT "count"(*)
FROM
  hive.tpcds_300gb_orc.store_sales
, hive.tpcds_300gb_orc.household_demographics
, hive.tpcds_300gb_orc.time_dim
, hive.tpcds_300gb_orc.store
WHERE ("ss_sold_time_sk" = "time_dim"."t_time_sk")
   AND ("ss_hdemo_sk" = "household_demographics"."hd_demo_sk")
   AND ("ss_store_sk" = "s_store_sk")
   AND ("time_dim"."t_hour" = 20)
   AND ("time_dim"."t_minute" >= 30)
   AND ("household_demographics"."hd_dep_count" = 7)
   AND ("store"."s_store_name" = 'ese')
ORDER BY "count"(*) ASC
LIMIT 100;
