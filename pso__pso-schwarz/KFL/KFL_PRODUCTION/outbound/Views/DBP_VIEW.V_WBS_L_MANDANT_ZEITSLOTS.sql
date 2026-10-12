CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wbs_l_mandant_zeitslots AS SELECT mandant_id,
 zeitslot_id,
 zeitslot_bez
FROM kfl_production_dbp_data.wbs_l_mandant_zeitslots;