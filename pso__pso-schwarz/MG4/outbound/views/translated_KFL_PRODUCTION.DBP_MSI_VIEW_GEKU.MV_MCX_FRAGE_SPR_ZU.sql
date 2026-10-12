-- 20190404 twie: SPEC0053317 Umfrage im Schlüssel
 -- weitere Felder aktuell nicht benötigt

-- 20180502 twie: SPEC0037245 Neuanlage Sprachview Frage in Maritz

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_mcx_frage_spr_zu (frage_id, umfrage_id, frage_bez,
frage_bez_cz, frage_bez_pl, frage_bez_sk, frage_bez_hr, frage_bez_ro, frage_bez_bg) AS -- standard=deutsch
 SELECT
 frage_id,
 umfrage_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN frage_bez
   ELSE NULL
   END) AS frage_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN frage_bez
   ELSE NULL
   END) AS frage_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN frage_bez
   ELSE NULL
   END) AS frage_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN frage_bez
   ELSE NULL
   END) AS frage_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN frage_bez
   ELSE NULL
   END) AS frage_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN frage_bez
   ELSE NULL
   END) AS frage_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN frage_bez
   ELSE NULL
   END) AS frage_bez_bg
FROM kfl_production_dbp_view.v_mcx_frage_spr_zu
GROUP BY frage_id,
 umfrage_id;