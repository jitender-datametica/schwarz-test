CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_geku_ticket_text (geku_ticket_id, textart_id,
dat_start, dat_ende, text) AS SELECT T1.geku_ticket_id,
 T1.textart_id,
 T2.dat_start,
 T2.dat_ende,
 T1.text
FROM kfl_production_dbp_view.v_geku_ticket_text AS T1
 INNER JOIN kfl_production_dbp_view.v_geku_ticket AS T2 ON T1.geku_ticket_id = T2.geku_ticket_id;