CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_ticket_text_2 (geku_ticket_id, textart_id, dat_start,
dat_ende, mandant_id, nb_id, wup_id, text) AS SELECT T1.geku_ticket_id,
 T1.textart_id,
 T2.dat_start,
 T2.dat_ende,
 T2.mandant_id_wup AS mandant_id,
 T2.nb_id,
 T2.wup_id,
 T1.text
FROM kfl_production_dbp_view.v_geku_ticket_text_2 AS T1_2
 INNER JOIN kfl_production_dbp_view.v_geku_ticket_2 AS T2 ON T1.geku_ticket_id = T2.geku_ticket_id;