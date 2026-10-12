CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geschlecht_spr_zu_2 (geschlecht_id, geschlecht_bez,
geschlecht_bez_cz, geschlecht_bez_pl, geschlecht_bez_sk, geschlecht_bez_hr, geschlecht_bez_ro, geschlecht_bez_bg) AS
SELECT V01.zusatzinfo_sel_id AS geschlecht_id,
 MAX(CASE
   WHEN V03.spr_id = 22
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS geschlecht_bez,
 MAX(CASE
   WHEN V03.spr_id = 124
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS geschlecht_bez_cz,
 MAX(CASE
   WHEN V03.spr_id = 90
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS geschlecht_bez_pl,
 MAX(CASE
   WHEN V03.spr_id = 108
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS geschlecht_bez_sk,
 MAX(CASE
   WHEN V03.spr_id = 65
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS geschlecht_bez_hr,
 MAX(CASE
   WHEN V03.spr_id = 95
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS geschlecht_bez_ro,
 MAX(CASE
   WHEN V03.spr_id = 18
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS geschlecht_bez_bg
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_2 AS V02 ON V01.zusatzinfo_id = V02.zusatzinfo_id
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_sel_spr_zu_2 AS V03 ON V01.zusatzinfo_sel_id = V03.zusatzinfo_sel_id
  
WHERE V02.spr_id = 22
 AND V02.zusatzinfo_bez = 'Geschlecht'
GROUP BY geschlecht_id
UNION ALL
SELECT - 1 AS geschlecht_id,
 '' AS geschlecht_bez,
 '' AS geschlecht_bez_cz,
 '' AS geschlecht_bez_pl,
 '' AS geschlecht_bez_sk,
 '' AS geschlecht_bez_hr,
 '' AS geschlecht_bez_ro,
 '' AS geschlecht_bez_bg
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 1;