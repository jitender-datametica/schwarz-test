CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_ticket_text_kommentar_2 (geku_ticket_id, textart_id, text)
AS SELECT geku_ticket_id,
 textart_id,
 text
FROM kfl_production_dbp_view.v_geku_ticket_text_2
WHERE textart_id = 1;