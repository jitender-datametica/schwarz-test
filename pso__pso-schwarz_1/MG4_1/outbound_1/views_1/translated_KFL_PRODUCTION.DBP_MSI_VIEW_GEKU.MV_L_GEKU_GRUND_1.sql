-- 09.09.2015 twie: Lookup für Grund (2. Ebene)

-- für die es keine Kindelemente gibt (Dateileichen, können nie ein Ticket zugeordnet haben)

-- Filterung über DWH Artikel_1 (3. Ebene) damit für Grund keine Elemente angezeigt werden

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_geku_grund_1 (geku_grund_uid, geku_grund_id, geku_bereich_uid
) AS SELECT geku_grund_uid,
 geku_grund_id,
 geku_bereich_uid
FROM kfl_production_dbp_view.v_l_geku_grund_1
WHERE geku_grund_uid IN (SELECT geku_grund_uid
   FROM kfl_production_dbp_view.v_l_geku_dwh_artikel_1);