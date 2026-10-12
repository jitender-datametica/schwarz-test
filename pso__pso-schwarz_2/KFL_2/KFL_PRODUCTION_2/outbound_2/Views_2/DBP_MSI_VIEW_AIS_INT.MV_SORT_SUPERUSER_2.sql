CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_sort_superuser_2 (mandant_id, user_id, superuser_fg,
teilsortiment_fg) AS SELECT V01.mandant_id,
 COALESCE(v02.user_id, V01.user_id) AS user_id,
  CASE
  WHEN V01.wg_id = - 999
  THEN 1
  ELSE 0
  END AS superuser_fg,
  CASE
  WHEN v02.user_id IS NOT NULL
  THEN 1
  ELSE 0
  END AS teilsortiment_fg
FROM kfl_production_dbp_security.sortiment_user_wg_zu_2 AS V01
 LEFT JOIN (SELECT DISTINCT user_id,
   mandant_id
  FROM kfl_production_dbp_security.user_zek_zu_2) AS v02 ON V01.user_id = v02.user_id AND V01.mandant_id = v02.mandant_id;