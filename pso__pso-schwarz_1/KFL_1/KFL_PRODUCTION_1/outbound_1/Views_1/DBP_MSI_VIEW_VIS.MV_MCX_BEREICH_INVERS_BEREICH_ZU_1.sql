CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mcx_bereich_invers_bereich_zu_1 AS SELECT ber_id,
 invers_ber_id,
 ber_sort,
 umfrage_id,
 filter_fg
FROM kfl_production_dbp_view.v_mcx_bereich_invers_bereich_zu_1;