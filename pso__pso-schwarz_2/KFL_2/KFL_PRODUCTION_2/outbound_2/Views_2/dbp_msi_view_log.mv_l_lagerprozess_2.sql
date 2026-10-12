CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_lagerprozess_2 AS SELECT mandant_id,
 lagernummer_id,
 lagerprozess_id,
 richtung_id
FROM kfl_production_dbp_view.v_l_lagerprozess_2 AS V01;