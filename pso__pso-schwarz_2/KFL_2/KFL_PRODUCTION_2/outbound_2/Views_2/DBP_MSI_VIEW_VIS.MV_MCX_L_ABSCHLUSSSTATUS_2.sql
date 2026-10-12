CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mcx_l_abschlussstatus_2 AS SELECT abschluss_id,
 umfrage_id,
 2 AS kmr_quelle_id,
 abschluss_bez
FROM kfl_production_dbp_view.v_mcx_l_abschlussstatus_2;