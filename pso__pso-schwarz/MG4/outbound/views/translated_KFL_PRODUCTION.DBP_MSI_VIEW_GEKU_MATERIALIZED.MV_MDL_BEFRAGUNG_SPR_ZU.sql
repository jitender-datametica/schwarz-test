-- 19.11.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Modify issue with data
 -- standard=deutsch

-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_mdl_befragung_spr_zu (befragung_id, befragung_bez,
befragung_bez_cz, befragung_bez_pl, befragung_bez_sk, befragung_bez_hr, befragung_bez_ro, befragung_bez_bg) AS SELECT
 befragung_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN befragung_bez
   ELSE NULL
   END) AS befragung_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN befragung_bez
   ELSE NULL
   END) AS befragung_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN befragung_bez
   ELSE NULL
   END) AS befragung_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN befragung_bez
   ELSE NULL
   END) AS befragung_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN befragung_bez
   ELSE NULL
   END) AS befragung_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN befragung_bez
   ELSE NULL
   END) AS befragung_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN befragung_bez
   ELSE NULL
   END) AS befragung_bez_bg
FROM kfl_production_dbp_view.v_mdl_befragung_spr_zu AS v01
GROUP BY befragung_id;