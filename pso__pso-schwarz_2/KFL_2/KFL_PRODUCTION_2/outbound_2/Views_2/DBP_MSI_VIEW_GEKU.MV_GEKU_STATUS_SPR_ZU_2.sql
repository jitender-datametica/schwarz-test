CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_status_spr_zu_2 (geku_status_id, geku_status_bez,
geku_status_bez_cz, geku_status_bez_pl, geku_status_bez_sk, geku_status_bez_hr, geku_status_bez_ro, geku_status_bez_bg)
AS SELECT geku_status_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN geku_status_bez
   ELSE NULL
   END) AS geku_status_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN geku_status_bez
   ELSE NULL
   END) AS geku_status_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN geku_status_bez
   ELSE NULL
   END) AS geku_status_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN geku_status_bez
   ELSE NULL
   END) AS geku_status_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN geku_status_bez
   ELSE NULL
   END) AS geku_status_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN geku_status_bez
   ELSE NULL
   END) AS geku_status_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN geku_status_bez
   ELSE NULL
   END) AS geku_status_bez_bg
FROM kfl_production_dbp_view.v_geku_status_spr_zu_2 AS V01
GROUP BY geku_status_id;