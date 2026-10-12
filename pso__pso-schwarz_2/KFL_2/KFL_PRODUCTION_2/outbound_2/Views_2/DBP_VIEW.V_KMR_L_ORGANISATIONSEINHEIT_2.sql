CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kmr_l_organisationseinheit_2 AS SELECT amx_system_id,
 orga_einheit_id,
 orga_einheit_imp_referenz,
 orga_einheit_bez,
 mandant_id,
 wup_id,
 nb_id
FROM kfl_production_dbp_data.kmr_l_organisationseinheit_2;