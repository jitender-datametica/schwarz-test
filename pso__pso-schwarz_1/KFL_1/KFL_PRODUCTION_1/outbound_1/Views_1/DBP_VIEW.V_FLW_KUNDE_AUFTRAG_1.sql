CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_kunde_auftrag_1 AS SELECT mandant_id,
 verkaufs_beleg_id,
 flw_vw_id,
 system_id,
 dat_erstellung,
 best_beleg_id_kunde,
 auftragsart_id,
 flw_verkaufsorganisation_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_kunde_auftrag_1;