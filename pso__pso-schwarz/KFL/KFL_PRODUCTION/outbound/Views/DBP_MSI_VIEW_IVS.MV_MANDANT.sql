CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_mandant AS SELECT mandant_id,
 mandant_bez,
 mandant_kbez
FROM kfl_production_dbp_view.v_mandant AS M;