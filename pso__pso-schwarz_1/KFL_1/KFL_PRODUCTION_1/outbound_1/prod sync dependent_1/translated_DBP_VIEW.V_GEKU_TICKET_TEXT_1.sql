CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_ticket_text_1 (geku_ticket_id, textart_id, text, td_update,
td_insert) AS SELECT geku_ticket_id,
 textart_id,
 text,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_ticket_text_1;