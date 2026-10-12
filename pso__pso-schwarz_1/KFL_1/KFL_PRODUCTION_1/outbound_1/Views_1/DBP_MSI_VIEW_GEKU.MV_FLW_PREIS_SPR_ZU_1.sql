CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_flw_preis_spr_zu_1 (flw_preis_id, flw_preis_bez,
flw_preis_bez_cz, flw_preis_bez_pl, flw_preis_bez_sk, flw_preis_bez_hr, flw_preis_bez_ro, flw_preis_bez_bg) AS SELECT
 V01.zusatzinfo_sel_id AS flw_preis_id,
 MAX(CASE
   WHEN V03.spr_id = 22
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_preis_bez,
 MAX(CASE
   WHEN V03.spr_id = 124
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_preis_bez_cz,
 MAX(CASE
   WHEN V03.spr_id = 90
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_preis_bez_pl,
 MAX(CASE
   WHEN V03.spr_id = 108
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_preis_bez_sk,
 MAX(CASE
   WHEN V03.spr_id = 65
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_preis_bez_hr,
 MAX(CASE
   WHEN V03.spr_id = 95
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_preis_bez_ro,
 MAX(CASE
   WHEN V03.spr_id = 18
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_preis_bez_bg
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_1 AS V02 ON V01.zusatzinfo_id = V02.zusatzinfo_id
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_sel_spr_zu_1 AS V03 ON V01.zusatzinfo_sel_id = V03.zusatzinfo_sel_id
  
WHERE V02.spr_id = 22
 AND V02.zusatzinfo_bez = 'FLW Preis'
GROUP BY flw_preis_id
UNION ALL
SELECT - 1 AS flw_preis_id,
 '' AS flw_preis_bez,
 '' AS flw_preis_bez_cz,
 '' AS flw_preis_bez_pl,
 '' AS flw_preis_bez_sk,
 '' AS flw_preis_bez_hr,
 '' AS flw_preis_bez_ro,
 '' AS flw_preis_bez_bg
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id = 1;