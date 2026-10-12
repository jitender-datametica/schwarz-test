CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_status_fremdkoerp_spr_zu_1 (status_fremdkoerper_id,
status_fremdkoerper_bez, status_fremdkoerper_bez_cz, status_fremdkoerper_bez_pl, status_fremdkoerper_bez_sk,
status_fremdkoerper_bez_hr, status_fremdkoerper_bez_ro, status_fremdkoerper_bez_bg) AS SELECT V01.zusatzinfo_sel_id AS
 status_fremdkoerper_id,
 MAX(CASE
   WHEN V03.spr_id = 22
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS status_fremdkoerper_bez,
 MAX(CASE
   WHEN V03.spr_id = 124
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS status_fremdkoerper_bez_cz,
 MAX(CASE
   WHEN V03.spr_id = 90
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS status_fremdkoerper_bez_pl,
 MAX(CASE
   WHEN V03.spr_id = 108
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS status_fremdkoerper_bez_sk,
 MAX(CASE
   WHEN V03.spr_id = 65
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS status_fremdkoerper_bez_hr,
 MAX(CASE
   WHEN V03.spr_id = 95
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS status_fremdkoerper_bez_ro,
 MAX(CASE
   WHEN V03.spr_id = 18
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS status_fremdkoerper_bez_bg
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_1 AS V02 ON V01.zusatzinfo_id = V02.zusatzinfo_id
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_sel_spr_zu_1 AS V03 ON V01.zusatzinfo_sel_id = V03.zusatzinfo_sel_id
  
WHERE V02.spr_id = 22
 AND V02.zusatzinfo_bez = 'Status_1 Fremdkörper'
GROUP BY status_fremdkoerper_id
UNION ALL
SELECT - 1 AS status_fremdkoerper_id,
 '' AS status_fremdkoerper_bez,
 '' AS status_fremdkoerper_bez_cz,
 '' AS status_fremdkoerper_bez_pl,
 '' AS status_fremdkoerper_bez_sk,
 '' AS status_fremdkoerper_bez_hr,
 '' AS status_fremdkoerper_bez_ro,
 '' AS status_fremdkoerper_bez_bg
FROM kfl_production_dbp_view.v_mandant_1
WHERE mandant_id = 1;