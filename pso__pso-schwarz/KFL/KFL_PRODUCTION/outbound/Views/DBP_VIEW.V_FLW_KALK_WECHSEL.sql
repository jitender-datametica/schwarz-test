CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_kalk_wechsel AS SELECT auftrag_id,
 mandant_id,
 dat_kalk,
 trennprozess_id,
 wechsel_id,
 werk_id,
 system_id,
 flw_lief_id,
 materialwert_kalk_id,
 tiergattung_id,
 schnittliste_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_kalk_wechsel;