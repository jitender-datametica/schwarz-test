CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mcx_l_bereich_2 AS SELECT BER.ber_id,
 BER.umfrage_id,
 COALESCE(bib.filter_fg, 1) AS ber_filter_fg,
 COALESCE(bib.ber_sort, - 1) AS ber_sort
FROM kfl_production_dbp_view.v_mcx_l_bereich_2 AS BER
 LEFT JOIN (SELECT DISTINCT ber_id,
   umfrage_id,
   filter_fg,
   ber_sort
  FROM kfl_production_dbp_view.v_mcx_bereich_invers_bereich_zu_2) AS bib ON BER.ber_id = bib.ber_id;