CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_schaedlingsart_spr_zu (schaedlingsart_id, schaedlingsart_bez
, schaedlingsart_bez_cz, schaedlingsart_bez_pl, schaedlingsart_bez_sk, schaedlingsart_bez_hr, schaedlingsart_bez_ro,
schaedlingsart_bez_bg) AS SELECT V01.zusatzinfo_sel_id AS schaedlingsart_id,
 MAX(CASE
   WHEN V03.spr_id = 22
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS schaedlingsart_bez,
 MAX(CASE
   WHEN V03.spr_id = 124
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS schaedlingsart_bez_cz,
 MAX(CASE
   WHEN V03.spr_id = 90
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS schaedlingsart_bez_pl,
 MAX(CASE
   WHEN V03.spr_id = 108
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS schaedlingsart_bez_sk,
 MAX(CASE
   WHEN V03.spr_id = 65
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS schaedlingsart_bez_hr,
 MAX(CASE
   WHEN V03.spr_id = 95
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS schaedlingsart_bez_ro,
 MAX(CASE
   WHEN V03.spr_id = 18
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS schaedlingsart_bez_bg
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu AS V01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu AS V02 ON V01.zusatzinfo_id = V02.zusatzinfo_id
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_sel_spr_zu AS V03 ON V01.zusatzinfo_sel_id = V03.zusatzinfo_sel_id
  
WHERE V02.spr_id = 22
 AND V02.zusatzinfo_bez = 'Schädlingsart'
GROUP BY schaedlingsart_id
UNION ALL
SELECT - 1 AS schaedlingsart_id,
 '' AS schaedlingsart_bez,
 '' AS schaedlingsart_bez_cz,
 '' AS schaedlingsart_bez_pl,
 '' AS schaedlingsart_bez_sk,
 '' AS schaedlingsart_bez_hr,
 '' AS schaedlingsart_bez_ro,
 '' AS schaedlingsart_bez_bg
FROM kfl_production_dbp_view.v_mandant
WHERE mandant_id = 1;