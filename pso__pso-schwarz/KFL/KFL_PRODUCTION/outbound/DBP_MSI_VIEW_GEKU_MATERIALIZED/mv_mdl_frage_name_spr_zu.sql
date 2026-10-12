-- 19.11.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Modify issue with data
 -- standard=deutsch

-- 22.09.2020 SPEC0087215, AP0066293, Pawel Staniszewski, Creation of the View

CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_mdl_frage_name_spr_zu (frage_id, frage_name_bez
, frage_name_bez_cz, frage_name_bez_pl, frage_name_bez_sk, frage_name_bez_hr, frage_name_bez_ro, frage_name_bez_bg) AS
SELECT frage_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN frage_name_bez
   ELSE NULL
   END) AS frage_name_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN frage_name_bez
   ELSE NULL
   END) AS frage_name_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN frage_name_bez
   ELSE NULL
   END) AS frage_name_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN frage_name_bez
   ELSE NULL
   END) AS frage_name_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN frage_name_bez
   ELSE NULL
   END) AS frage_name_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN frage_name_bez
   ELSE NULL
   END) AS frage_name_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN frage_name_bez
   ELSE NULL
   END) AS frage_name_bez_bg
FROM dbp_view.v_mdl_frage_name_spr_zu AS V01
GROUP BY frage_id;