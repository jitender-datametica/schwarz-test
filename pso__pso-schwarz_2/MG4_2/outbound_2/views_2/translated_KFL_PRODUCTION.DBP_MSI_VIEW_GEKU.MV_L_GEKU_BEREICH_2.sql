-- Filterung über Grund (2. Ebene) damit für Bereich keine Elemente angezeigt werden

-- 12.10.2022 twie: SPEC0167837 sek_kz von variabel 1 - 7 auf 3 geändert

-- für die es keine Kindelemente gibt (Dateileichen, können nie ein Ticket zugeordnet haben)

-- 09.09.2015 twie: Lookup für Bereich (1. Ebene)

-- 21.07.2017 twie: SPEC0025359 neues Security Kennzeichen für Sicherheitsfilter

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_geku_bereich_2 (geku_bereich_uid, geku_bereich_id, kdc_fg,
mzk_fg, wmd_fg, sec_kz) AS SELECT geku_bereich_uid,
 geku_bereich_id,
 kdc_fg,
 mzk_fg,
 wmd_fg,
 3 AS sec_kz
FROM kfl_production_dbp_view.v_l_geku_bereich_2
WHERE geku_bereich_uid IN (SELECT geku_bereich_uid
   FROM kfl_production_dbp_view.v_l_geku_grund_2);