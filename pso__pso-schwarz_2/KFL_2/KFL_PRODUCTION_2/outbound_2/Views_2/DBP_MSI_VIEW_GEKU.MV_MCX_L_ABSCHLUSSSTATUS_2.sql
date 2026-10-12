CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_mcx_l_abschlussstatus_2 (abschluss_id, umfrage_id,
abschluss_bez) AS SELECT abschluss_id,
 umfrage_id,
 abschluss_bez
FROM kfl_production_dbp_view.v_mcx_l_abschlussstatus_2;