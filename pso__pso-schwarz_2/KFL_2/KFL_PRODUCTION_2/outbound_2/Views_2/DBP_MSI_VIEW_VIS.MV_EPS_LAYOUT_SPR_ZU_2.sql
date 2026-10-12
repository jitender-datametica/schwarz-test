CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_eps_layout_spr_zu_2 AS SELECT layout_kz,
 MAX(CASE
   WHEN spr_id = 22
   THEN layout_bez
   ELSE NULL
   END) AS layout_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN layout_bez
   ELSE NULL
   END) AS layout_bez_cz,
 MAX(CASE
   WHEN spr_id = 108
   THEN layout_bez
   ELSE NULL
   END) AS layout_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN layout_bez
   ELSE NULL
   END) AS layout_bez_hr,
 MAX(CASE
   WHEN spr_id = 90
   THEN layout_bez
   ELSE NULL
   END) AS layout_bez_pl,
 MAX(CASE
   WHEN spr_id = 95
   THEN layout_bez
   ELSE NULL
   END) AS layout_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN layout_bez
   ELSE NULL
   END) AS layout_bez_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN layout_bez
   ELSE NULL
   END) AS layout_bez_de
FROM kfl_production_dbp_view.v_eps_layout_spr_zu_2
GROUP BY layout_kz;