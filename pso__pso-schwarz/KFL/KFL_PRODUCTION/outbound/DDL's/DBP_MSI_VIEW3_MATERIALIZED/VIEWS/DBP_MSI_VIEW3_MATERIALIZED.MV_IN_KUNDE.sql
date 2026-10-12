CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_in_kunde (mandant_id, in_kunde_id, kunde_nr,
kunde_name, system_id) AS SELECT mandant_id,
 in_kunde_id,
 kunde_nr,
 kunde_name,
 system_id
FROM kfl_production_dbp_view.v_in_kunde;