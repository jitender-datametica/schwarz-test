-- 08.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

-- für die es keine Kindelemente gibt (Dateileichen, können nie ein Ticket zugeordnet haben)

-- 09.09.2015 twie: Sprachview für Bereich (1. Ebene)

-- Filterung über Grund (2. Ebene) damit für Bereich keine Elemente angezeigt werden

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_bereich_spr_zu_1 (geku_bereich_uid, geku_bereich_bez,
geku_bereich_bez_cz, geku_bereich_bez_pl, geku_bereich_bez_sk, geku_bereich_bez_hr, geku_bereich_bez_ro,
geku_bereich_bez_bg) AS -- standard=deutsch
 SELECT geku_bereich_uid,
 MAX(CASE
   WHEN spr_id = 22
   THEN geku_bereich_bez
   ELSE NULL
   END) AS geku_bereich_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN geku_bereich_bez
   ELSE NULL
   END) AS geku_bereich_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN geku_bereich_bez
   ELSE NULL
   END) AS geku_bereich_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN geku_bereich_bez
   ELSE NULL
   END) AS geku_bereich_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN geku_bereich_bez
   ELSE NULL
   END) AS geku_bereich_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN geku_bereich_bez
   ELSE NULL
   END) AS geku_bereich_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN geku_bereich_bez
   ELSE NULL
   END) AS geku_bereich_bez_bg
FROM kfl_production_dbp_view.v_geku_bereich_spr_zu_1 AS v01
WHERE geku_bereich_uid IN (SELECT geku_bereich_uid
   FROM kfl_production_dbp_view.v_l_geku_grund_1)
GROUP BY geku_bereich_uid;