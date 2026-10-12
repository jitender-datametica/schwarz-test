CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_fw_saison AS SELECT fw_saison_id,
 mandant_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.l_fw_saison;