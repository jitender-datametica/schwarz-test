CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kmr_pruefprogramm_kapitel_2 AS SELECT amx_system_id,
 kapitel_id,
 kapitel_bez,
 kapitel_typ_id,
 pruefung_id,
 kapitel_nr,
 sort_nr,
 fehlerverdacht_fg,
 gepr_prozess_id,
 ergebnis,
 ergebnis_berechnet,
 ergebnis_manuell
FROM kfl_production_dbp_data.kmr_pruefprogramm_kapitel_2;