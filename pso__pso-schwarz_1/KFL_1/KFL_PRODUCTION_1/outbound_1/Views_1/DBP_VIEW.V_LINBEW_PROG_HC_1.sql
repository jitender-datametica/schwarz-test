CREATE OR REPLACE VIEW kfl_production_dbp_view.v_linbew_prog_hc_1 AS SELECT mandant_id,
 wup_id,
 dat,
 anz_prg_beendet,
 anz_prg_faellig,
 anz_prg_gesamt,
 anz_prg_bearbeitung,
 anz_prg_ausstehend,
 td_insert,
 td_update
FROM kfl_production_dbp_data.linbew_prog_hc_1;