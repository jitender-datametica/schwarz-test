CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_hersteller_food_spr_zu (hersteller_food_id,
hersteller_food_bez, hersteller_food_bez_cz, hersteller_food_bez_pl, hersteller_food_bez_sk, hersteller_food_bez_hr,
hersteller_food_bez_ro, hersteller_food_bez_bg) AS SELECT V01.zusatzinfo_sel_id AS hersteller_food_id,
 MAX(CASE
   WHEN V03.spr_id = 22
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_food_bez,
 MAX(CASE
   WHEN V03.spr_id = 124
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_food_bez_cz,
 MAX(CASE
   WHEN V03.spr_id = 90
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_food_bez_pl,
 MAX(CASE
   WHEN V03.spr_id = 108
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_food_bez_sk,
 MAX(CASE
   WHEN V03.spr_id = 65
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_food_bez_hr,
 MAX(CASE
   WHEN V03.spr_id = 95
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_food_bez_ro,
 MAX(CASE
   WHEN V03.spr_id = 18
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS hersteller_food_bez_bg
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu AS V02 ON V01.zusatzinfo_id = V02.zusatzinfo_id
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_sel_spr_zu AS V03 ON V01.zusatzinfo_sel_id = V03.zusatzinfo_sel_id
  
WHERE V02.spr_id = 22
 AND V02.zusatzinfo_bez = 'Hersteller Food'
GROUP BY hersteller_food_id
UNION ALL
SELECT - 1 AS hersteller_food_id,
 '' AS hersteller_food_bez,
 '' AS hersteller_food_bez_cz,
 '' AS hersteller_food_bez_pl,
 '' AS hersteller_food_bez_sk,
 '' AS hersteller_food_bez_hr,
 '' AS hersteller_food_bez_ro,
 '' AS hersteller_food_bez_bg
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;