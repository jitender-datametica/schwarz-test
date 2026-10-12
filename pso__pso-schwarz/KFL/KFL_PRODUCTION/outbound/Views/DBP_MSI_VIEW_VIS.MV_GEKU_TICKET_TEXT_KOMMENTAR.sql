CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_ticket_text_kommentar (geku_ticket_id, textart_id, text)
AS SELECT geku_ticket_id,
 textart_id,
 text
FROM kfl_production_dbp_view.v_geku_ticket_text
WHERE textart_id = 1;