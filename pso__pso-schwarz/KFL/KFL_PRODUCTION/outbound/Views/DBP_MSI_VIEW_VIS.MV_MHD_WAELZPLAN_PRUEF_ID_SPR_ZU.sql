CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mhd_waelzplan_pruef_id_spr_zu (mandant_id, waelzplan_pruef_id
, waelzplan_pruef_bez, waelzplan_pruef_bez_cz, waelzplan_pruef_bez_pl, waelzplan_pruef_bez_sk, waelzplan_pruef_bez_hr,
waelzplan_pruef_bez_ro, waelzplan_pruef_bez_bg) AS SELECT mandant_id,
 waelzplan_pruef_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN waelzplan_pruef_bez
   ELSE NULL
   END) AS waelzplan_pruef_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN waelzplan_pruef_bez
   ELSE NULL
   END) AS waelzplan_pruef_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN waelzplan_pruef_bez
   ELSE NULL
   END) AS waelzplan_pruef_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN waelzplan_pruef_bez
   ELSE NULL
   END) AS waelzplan_pruef_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN waelzplan_pruef_bez
   ELSE NULL
   END) AS waelzplan_pruef_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN waelzplan_pruef_bez
   ELSE NULL
   END) AS waelzplan_pruef_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN waelzplan_pruef_bez
   ELSE NULL
   END) AS waelzplan_pruef_bez_bg
FROM kfl_production_dbp_view.v_mhd_waelzplan_pruef_id_spr_zu
GROUP BY mandant_id,
 waelzplan_pruef_id;