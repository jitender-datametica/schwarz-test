CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_lagerprozess_1 AS SELECT mandant_id,
 lagernummer_id,
 lagerprozess_id,
 richtung_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_lagerprozess_1;