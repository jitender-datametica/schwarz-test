-- für die es keine Kindelemente gibt (Dateileichen, können nie ein Ticket zugeordnet haben)

-- 09.09.2015 twie: Sprachview für Grund (2. Ebene)
 -- 27.02.2017 twie: SPEC0019359 Umstellung spaltenbasiert

-- Filterung über DWH Artikel_2 (3. Ebene) damit für Grund keine Elemente angezeigt werden

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_geku_grund_spr_zu_2 (geku_grund_uid, geku_grund_bez,
geku_grund_bez_cz, geku_grund_bez_pl, geku_grund_bez_sk, geku_grund_bez_hr, geku_grund_bez_ro, geku_grund_bez_bg) AS
-- standard=deutsch
 SELECT geku_grund_uid,
 MAX(CASE
   WHEN spr_id = 22
   THEN geku_grund_bez
   ELSE NULL
   END) AS geku_grund_bez,
 MAX(CASE
   WHEN spr_id = 124
   THEN geku_grund_bez
   ELSE NULL
   END) AS geku_grund_bez_cz,
 MAX(CASE
   WHEN spr_id = 90
   THEN geku_grund_bez
   ELSE NULL
   END) AS geku_grund_bez_pl,
 MAX(CASE
   WHEN spr_id = 108
   THEN geku_grund_bez
   ELSE NULL
   END) AS geku_grund_bez_sk,
 MAX(CASE
   WHEN spr_id = 65
   THEN geku_grund_bez
   ELSE NULL
   END) AS geku_grund_bez_hr,
 MAX(CASE
   WHEN spr_id = 95
   THEN geku_grund_bez
   ELSE NULL
   END) AS geku_grund_bez_ro,
 MAX(CASE
   WHEN spr_id = 18
   THEN geku_grund_bez
   ELSE NULL
   END) AS geku_grund_bez_bg
FROM kfl_production_dbp_view.v_geku_grund_spr_zu_2 AS v01
WHERE geku_grund_uid IN (SELECT geku_grund_uid
   FROM kfl_production_dbp_view.v_l_geku_dwh_artikel_2)
GROUP BY geku_grund_uid;