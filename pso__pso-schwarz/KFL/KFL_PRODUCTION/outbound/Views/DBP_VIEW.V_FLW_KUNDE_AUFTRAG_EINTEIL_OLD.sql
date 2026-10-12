CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_kunde_auftrag_einteil_old AS SELECT mandant_id,
 verkaufs_beleg_id,
 verkaufs_beleg_pos_id,
 einteil_id,
 system_id,
 dat_einteilung,
 zeit_einteilung,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_kunde_auftrag_einteil;