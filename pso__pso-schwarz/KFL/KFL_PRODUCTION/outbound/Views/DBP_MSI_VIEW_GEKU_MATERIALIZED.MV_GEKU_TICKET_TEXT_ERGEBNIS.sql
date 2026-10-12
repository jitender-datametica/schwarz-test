CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku_materialized.mv_geku_ticket_text_ergebnis (geku_ticket_id,
textart_id, text) AS SELECT geku_ticket_id,
 textart_id,
 CAST(text AS STRING) AS text
FROM kfl_production_dbp_view.v_geku_ticket_text
WHERE textart_id = 3;