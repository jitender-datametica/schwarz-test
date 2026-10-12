CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_geku_ticket_text_1 (geku_ticket_id, textart_id,
dat_start, dat_ende, text) AS SELECT T1.geku_ticket_id,
 T1.textart_id,
 T2.dat_start,
 T2.dat_ende,
 T1.text
FROM dbp_view.v_geku_ticket_text_1 AS T1_1
 INNER JOIN dbp_view.v_geku_ticket_1 AS T2 ON T1.geku_ticket_id = T2.geku_ticket_id;