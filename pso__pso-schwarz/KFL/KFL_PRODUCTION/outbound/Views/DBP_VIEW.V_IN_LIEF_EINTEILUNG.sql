CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_lief_einteilung AS SELECT best_beleg_id,
 best_beleg_pos_id,
 einteil_id,
 mandant_id,
 dat_lief_statistisch,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_lief_einteilung;