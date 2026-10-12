SELECT CASE
  WHEN SUM(count_of_wrong_rows) > 0
  THEN 1 / 0
  ELSE 0
  END AS check_sum
FROM (SELECT COUNT(*) AS count_of_wrong_rows
   FROM szd_production_etl.t_tf_cache_owim_2_check_owim_int
   UNION ALL
   SELECT COUNT(*) AS count_of_wrong_rows
   FROM szd_production_etl.t_tf_cache_excise_masterlist_2_check_excise_masterlist_int
   UNION ALL
   SELECT COUNT(*) AS count_of_wrong_rows
   FROM szd_production_etl.t_tf_cache_ceva_2_check_ceva_int
   UNION ALL
   SELECT COUNT(*) AS count_of_wrong_rows
   FROM szd_production_etl.t_tf_cache_cds_item_2_check_cds_item_int) AS t3;