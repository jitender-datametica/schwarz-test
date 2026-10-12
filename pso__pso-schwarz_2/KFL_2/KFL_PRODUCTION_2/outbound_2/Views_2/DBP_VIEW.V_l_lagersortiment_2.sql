CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lagersortiment_2 AS SELECT mandant_id,
 lagernummer_id,
 lagersortiment_id,
 wup_id,
 nb_id
FROM kfl_production_dbp_data.l_lagersortiment_2;