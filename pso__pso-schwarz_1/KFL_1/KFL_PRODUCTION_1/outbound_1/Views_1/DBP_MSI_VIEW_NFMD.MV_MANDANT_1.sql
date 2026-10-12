CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_mandant_1 AS SELECT DISTINCT mandant_id,
 mandant_bez,
 mandant_kbez,
 default_wrg
FROM kfl_production_dbp_view.v_mandant_1;