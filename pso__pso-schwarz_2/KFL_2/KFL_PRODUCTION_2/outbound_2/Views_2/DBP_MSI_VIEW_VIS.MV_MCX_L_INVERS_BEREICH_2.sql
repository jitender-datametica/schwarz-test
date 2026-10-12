CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_mcx_l_invers_bereich_2 AS SELECT IBE.invers_ber_id,
 IBE.invers_kat_id,
 BIB.umfrage_id,
 BIB.ber_sort AS invers_ber_sort,
 BIB.filter_fg AS invers_ber_filter_fg
FROM kfl_production_dbp_view.v_mcx_l_invers_bereich_2 AS IBE
 LEFT JOIN kfl_production_dbp_view.v_mcx_bereich_invers_bereich_zu_2 AS BIB ON IBE.invers_ber_id = BIB.invers_ber_id;