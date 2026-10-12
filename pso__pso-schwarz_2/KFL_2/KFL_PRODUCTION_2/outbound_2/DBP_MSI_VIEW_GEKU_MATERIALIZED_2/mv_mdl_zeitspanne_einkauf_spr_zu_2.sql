-- standard=deutsch
 -- 19.11.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Modify issue with data

-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_mdl_zeitspanne_einkauf_spr_zu_2 (zeitspanne_einkauf_id
, zeitspanne_einkauf_bez, zeitspanne_einkauf_bez_cz, zeitspanne_einkauf_bez_pl, zeitspanne_einkauf_bez_sk,
zeitspanne_einkauf_bez_hr, zeitspanne_einkauf_bez_ro, zeitspanne_einkauf_bez_bg) AS SELECT zeitspanne_einkauf_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN zeitspanne_einkauf_bez
   ELSE NULL
   END) AS zeitspanne_einkauf_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN zeitspanne_einkauf_bez
   ELSE NULL
   END) AS zeitspanne_einkauf_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN zeitspanne_einkauf_bez
   ELSE NULL
   END) AS zeitspanne_einkauf_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN zeitspanne_einkauf_bez
   ELSE NULL
   END) AS zeitspanne_einkauf_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN zeitspanne_einkauf_bez
   ELSE NULL
   END) AS zeitspanne_einkauf_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN zeitspanne_einkauf_bez
   ELSE NULL
   END) AS zeitspanne_einkauf_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN zeitspanne_einkauf_bez
   ELSE NULL
   END) AS zeitspanne_einkauf_bez_bg
FROM dbp_view.v_mdl_zeitspanne_einkauf_spr_zu_2 AS V01
GROUP BY zeitspanne_einkauf_id;