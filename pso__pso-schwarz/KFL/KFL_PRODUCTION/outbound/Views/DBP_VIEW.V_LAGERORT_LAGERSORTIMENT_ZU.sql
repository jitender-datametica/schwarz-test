CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lagerort_lagersortiment_zu AS SELECT mandant_id,
 lagerort_id,
 lagersortiment_id,
 wup_id,
 nb_id
FROM kfl_production_dbp_data.lagerort_lagersortiment_zu;