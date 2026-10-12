CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_werbeware (mandant_id, werbeware_id) AS SELECT mandant_id,
 werbeware_id
FROM kfl_production_dbp_view.v_l_werbeware;