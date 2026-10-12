CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mandant (mandant_id, mandant_sort_id, mandant_bez,
mandant_bez_cz, mandant_bez_sk, mandant_bez_hr, mandant_bez_pl, mandant_bez_ro, mandant_bez_bg, mandant_iso, default_wrg
, mandant_kbez, mandant_bez_old, mandant_nat_bez, mandant_nat_bez_cz, mandant_nat_bez_sk, mandant_nat_bez_hr,
mandant_nat_bez_pl, mandant_nat_bez_ro, mandant_nat_bez_bg) AS SELECT mandant_id,
 mandant_sort_id,
 CAST(CASE
   WHEN mandant_id = 2
   THEN 'Tschechien'
   WHEN mandant_id = 7
   THEN 'Rumänien'
   ELSE mandant_bez
   END AS STRING) AS mandant_bez,
 CAST(CASE
   WHEN mandant_id = 2
   THEN 'Česko'
   WHEN mandant_id = 5
   THEN 'Slovensko'
   ELSE mandant_bez
   END AS STRING) AS mandant_bez_cz,
 CAST(CASE
   WHEN mandant_id = 5
   THEN 'Slovensko'
   WHEN mandant_id = 2
   THEN 'Česko'
   ELSE mandant_bez
   END AS STRING) AS mandant_bez_sk,
 CAST(CASE
   WHEN mandant_id = 6
   THEN 'Hrvatska'
   ELSE mandant_bez
   END AS STRING) AS mandant_bez_hr,
 CAST(CASE
   WHEN mandant_id = 3
   THEN 'Polska'
   ELSE mandant_bez
   END AS STRING) AS mandant_bez_pl,
 CAST(CASE
   WHEN mandant_id = 4
   THEN 'Moldova'
   WHEN mandant_id = 7
   THEN 'România'
   ELSE mandant_bez
   END AS STRING) AS mandant_bez_ro,
 CAST(CASE
   WHEN mandant_id = 8
   THEN 'България'
   ELSE mandant_bez
   END AS STRING) AS mandant_bez_bg,
 CAST(CASE
   WHEN mandant_id = 1
   THEN 'DE'
   ELSE mandant_kbez
   END AS STRING) AS mandant_iso,
 default_wrg,
 mandant_kbez,
 mandant_bez AS mandant_bez_old,
 CAST(CASE
   WHEN mandant_id = 2
   THEN 'Tschechien'
   WHEN mandant_id = 7
   THEN 'Rumänien'
   ELSE mandant_bez
   END AS STRING) AS mandant_nat_bez,
 CAST(CASE
   WHEN mandant_id = 2
   THEN 'Česko'
   WHEN mandant_id = 5
   THEN 'Slovensko'
   ELSE mandant_bez
   END AS STRING) AS mandant_nat_bez_cz,
 CAST(CASE
   WHEN mandant_id = 5
   THEN 'Slovensko'
   WHEN mandant_id = 2
   THEN 'Česko'
   ELSE mandant_bez
   END AS STRING) AS mandant_nat_bez_sk,
 CAST(CASE
   WHEN mandant_id = 6
   THEN 'Hrvatska'
   ELSE mandant_bez
   END AS STRING) AS mandant_nat_bez_hr,
 CAST(CASE
   WHEN mandant_id = 3
   THEN 'Polska'
   ELSE mandant_bez
   END AS STRING) AS mandant_nat_bez_pl,
 CAST(CASE
   WHEN mandant_id = 4
   THEN 'Moldova'
   WHEN mandant_id = 7
   THEN 'România'
   ELSE mandant_bez
   END AS STRING) AS mandant_nat_bez_ro,
 CAST(CASE
   WHEN mandant_id = 8
   THEN 'България'
   ELSE mandant_bez
   END AS STRING) AS mandant_nat_bez_bg
FROM kfl_production_dbp_view.v_mandant;