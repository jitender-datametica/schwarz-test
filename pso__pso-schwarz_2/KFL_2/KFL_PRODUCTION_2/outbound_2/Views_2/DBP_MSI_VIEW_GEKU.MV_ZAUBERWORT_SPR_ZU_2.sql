CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_zauberwort_spr_zu_2 (zauberwort_id, zauberwort_bez,
zauberwort_bez_cz, zauberwort_bez_pl, zauberwort_bez_sk, zauberwort_bez_hr, zauberwort_bez_ro, zauberwort_bez_bg) AS
SELECT V01.zusatzinfo_sel_id AS zauberwort_id,
 MAX(CASE
   WHEN V03.spr_id = 22
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS zauberwort_bez,
 MAX(CASE
   WHEN V03.spr_id = 124
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS zauberwort_bez_cz,
 MAX(CASE
   WHEN V03.spr_id = 90
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS zauberwort_bez_pl,
 MAX(CASE
   WHEN V03.spr_id = 108
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS zauberwort_bez_sk,
 MAX(CASE
   WHEN V03.spr_id = 65
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS zauberwort_bez_hr,
 MAX(CASE
   WHEN V03.spr_id = 95
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS zauberwort_bez_ro,
 MAX(CASE
   WHEN V03.spr_id = 18
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS zauberwort_bez_bg
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_2 AS V02 ON V01.zusatzinfo_id = V02.zusatzinfo_id
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_sel_spr_zu_2 AS V03 ON V01.zusatzinfo_sel_id = V03.zusatzinfo_sel_id
  
WHERE V02.spr_id = 22
 AND V02.zusatzinfo_bez = 'Zauberwort'
GROUP BY zauberwort_id
UNION ALL
SELECT - 1 AS zauberwort_id,
 '' AS zauberwort_bez,
 '' AS zauberwort_bez_cz,
 '' AS zauberwort_bez_pl,
 '' AS zauberwort_bez_sk,
 '' AS zauberwort_bez_hr,
 '' AS zauberwort_bez_ro,
 '' AS zauberwort_bez_bg
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 1;