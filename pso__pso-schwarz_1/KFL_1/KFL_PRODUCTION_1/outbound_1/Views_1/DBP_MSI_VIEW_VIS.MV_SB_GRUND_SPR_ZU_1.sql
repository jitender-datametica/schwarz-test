CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_sb_grund_spr_zu_1 AS SELECT sb_grund_id,
 mandant_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN sb_grund_bez
   ELSE NULL
   END) AS sb_grund_bez_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN sb_grund_bez
   ELSE NULL
   END) AS sb_grund_bez_de,
 MAX(CASE
   WHEN spr_id = 124
   THEN sb_grund_bez
   ELSE NULL
   END) AS sb_grund_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN sb_grund_bez
   ELSE NULL
   END) AS sb_grund_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN sb_grund_bez
   ELSE NULL
   END) AS sb_grund_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN sb_grund_bez
   ELSE NULL
   END) AS sb_grund_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN sb_grund_bez
   ELSE NULL
   END) AS sb_grund_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN sb_grund_bez
   ELSE NULL
   END) AS sb_grund_bez_bg
FROM kfl_production_dbp_view.v_sb_grund_spr_zu_1 AS V01
GROUP BY sb_grund_id,
 mandant_id;