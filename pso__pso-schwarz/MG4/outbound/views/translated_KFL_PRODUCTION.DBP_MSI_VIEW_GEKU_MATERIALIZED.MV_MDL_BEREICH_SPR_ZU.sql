-- 21.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View
 -- standard=deutsch

-- 19.11.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Modify issue with data

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_mdl_bereich_spr_zu (bereich_id, bereich_bez, bereich_bez_cz,
bereich_bez_pl, bereich_bez_sk, bereich_bez_hr, bereich_bez_ro, bereich_bez_bg) AS SELECT bereich_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN bereich_bez
   ELSE NULL
   END) AS bereich_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN bereich_bez
   ELSE NULL
   END) AS bereich_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN bereich_bez
   ELSE NULL
   END) AS bereich_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN bereich_bez
   ELSE NULL
   END) AS bereich_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN bereich_bez
   ELSE NULL
   END) AS bereich_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN bereich_bez
   ELSE NULL
   END) AS bereich_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN bereich_bez
   ELSE NULL
   END) AS bereich_bez_bg
FROM kfl_production_dbp_view.v_mdl_bereich_spr_zu AS v01
GROUP BY bereich_id;