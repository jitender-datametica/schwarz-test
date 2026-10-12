CREATE OR REPLACE VIEW kfl_production_dbp_view.v_mcx_bereich_invers_bereich_zu AS SELECT ber_id,
 invers_ber_id,
 umfrage_id,
 filter_fg,
 ber_sort
FROM kfl_production_dbp_data.mcx_bereich_invers_bereich_zu;