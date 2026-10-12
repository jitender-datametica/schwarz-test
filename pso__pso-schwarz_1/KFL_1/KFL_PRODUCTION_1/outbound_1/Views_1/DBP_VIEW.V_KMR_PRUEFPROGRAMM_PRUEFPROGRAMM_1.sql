CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kmr_pruefprogramm_pruefprogramm_1 AS SELECT amx_system_id,
 pruefprogramm_id,
 pruefung_id,
 kapitel_nr,
 sort_nr,
 fehlerverdacht_fg,
 pruefprogramm_bez,
 gepr_prozess_id,
 ergebnis,
 ergebnis_berechnet,
 ergebnis_manuell
FROM kfl_production_dbp_data.kmr_pruefprogramm_pruefprogramm_1;