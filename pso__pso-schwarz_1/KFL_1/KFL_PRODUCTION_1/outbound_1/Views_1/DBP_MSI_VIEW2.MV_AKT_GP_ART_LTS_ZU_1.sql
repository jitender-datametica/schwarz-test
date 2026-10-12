CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_akt_gp_art_lts_zu_1 (mandant_id, akt_gp_id, art_id,
gp_teilsortiment_id) AS SELECT v02.mandant_id,
 v02.akt_gp_id,
 v02.art_id,
 COALESCE(V03.gp_teilsortiment_id, '999999') AS gp_teilsortiment_id
FROM (SELECT mandant_id,
   gp_id AS akt_gp_id,
   art_id
  FROM kfl_production_dbp_view.v_art_gp_nm_zu_per_1 AS V01
  WHERE dat_bis = DATE '9999-12-31'
   AND mandant_id = 1
  GROUP BY mandant_id,
   akt_gp_id,
   art_id) AS v02
 LEFT JOIN kfl_production_dbp_view.v_ek_infosatz_1 AS V03 ON v02.mandant_id = V03.mandant_id AND v02.art_id = V03.art_id
  AND v02.akt_gp_id = V03.gp_id
QUALIFY (RANK() OVER (PARTITION BY CAST(v02.mandant_id AS STRING), CAST(v02.akt_gp_id AS STRING), CAST(v02.art_id AS STRING)
      ORDER BY V03.ek_infosatz_id IS NULL, V03.ek_infosatz_id)) = 1;