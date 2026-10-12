CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_mandant_security (mandant_id, mandant_bez, mandant_kbez)
AS SELECT mandant_id,
 mandant_bez,
 mandant_kbez
FROM kfl_production_dbp_view.v_mandant AS V01;