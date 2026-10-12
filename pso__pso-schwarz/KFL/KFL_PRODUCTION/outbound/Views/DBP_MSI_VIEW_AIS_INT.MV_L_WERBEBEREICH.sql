CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_l_werbebereich (mandant_id, werbebereich_cd,
werbebereich_bez) AS SELECT mandant_id,
 werbebereich_cd,
 werbebereich_bez
FROM kfl_production_dbp_view.v_l_werbebereich AS V01;