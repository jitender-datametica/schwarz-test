CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lagerort AS SELECT mandant_id,
 lagerort_id,
 wup_id,
 nb_id,
 lagernummer_id
FROM kfl_production_dbp_data.l_lagerort;