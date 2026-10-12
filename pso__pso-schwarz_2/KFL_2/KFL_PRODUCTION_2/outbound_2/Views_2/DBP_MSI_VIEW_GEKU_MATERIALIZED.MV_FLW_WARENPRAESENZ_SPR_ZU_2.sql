CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_flw_warenpraesenz_spr_zu_2 (flw_warenpraesenz_id,
flw_warenpraesenz_bez, flw_warenpraesenz_bez_cz, flw_warenpraesenz_bez_pl, flw_warenpraesenz_bez_sk,
flw_warenpraesenz_bez_hr, flw_warenpraesenz_bez_ro, flw_warenpraesenz_bez_bg) AS SELECT V01.zusatzinfo_sel_id AS
 flw_warenpraesenz_id,
 MAX(CASE
   WHEN V03.spr_id = 22
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_warenpraesenz_bez,
 MAX(CASE
   WHEN V03.spr_id = 124
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_warenpraesenz_bez_cz,
 MAX(CASE
   WHEN V03.spr_id = 90
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_warenpraesenz_bez_pl,
 MAX(CASE
   WHEN V03.spr_id = 108
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_warenpraesenz_bez_sk,
 MAX(CASE
   WHEN V03.spr_id = 65
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_warenpraesenz_bez_hr,
 MAX(CASE
   WHEN V03.spr_id = 95
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_warenpraesenz_bez_ro,
 MAX(CASE
   WHEN V03.spr_id = 18
   THEN V03.zusatzinfo_sel_bez
   ELSE NULL
   END) AS flw_warenpraesenz_bez_bg
FROM kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_spr_zu_2 AS V02 ON V01.zusatzinfo_id = V02.zusatzinfo_id
 INNER JOIN kfl_production_dbp_view.v_geku_zusatzinfo_sel_spr_zu_2 AS V03 ON V01.zusatzinfo_sel_id = V03.zusatzinfo_sel_id
  
WHERE V02.spr_id = 22
 AND V02.zusatzinfo_bez = 'FLW Warenpräsenz'
GROUP BY flw_warenpraesenz_id
UNION ALL
SELECT -1 AS flw_warenpraesenz_id,
 '' AS flw_warenpraesenz_bez,
 '' AS flw_warenpraesenz_bez_cz,
 '' AS flw_warenpraesenz_bez_pl,
 '' AS flw_warenpraesenz_bez_sk,
 '' AS flw_warenpraesenz_bez_hr,
 '' AS flw_warenpraesenz_bez_ro,
 '' AS flw_warenpraesenz_bez_bg
FROM kfl_production_dbp_view.v_mandant_2
WHERE mandant_id = 1;