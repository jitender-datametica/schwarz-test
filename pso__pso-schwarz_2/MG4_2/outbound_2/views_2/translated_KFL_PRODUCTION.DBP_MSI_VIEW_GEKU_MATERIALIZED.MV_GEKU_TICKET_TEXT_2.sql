CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_geku_ticket_text_2 (geku_ticket_id, textart_id,
dat_start, dat_ende, text) AS SELECT t1.geku_ticket_id,
 t1.textart_id,
 t2.dat_start,
 t2.dat_ende,
 t1.text
FROM kfl_production_dbp_view.v_geku_ticket_text_2 AS t1_2
 INNER JOIN kfl_production_dbp_view.v_geku_ticket_2 AS t2 ON t1.geku_ticket_id = t2.geku_ticket_id;