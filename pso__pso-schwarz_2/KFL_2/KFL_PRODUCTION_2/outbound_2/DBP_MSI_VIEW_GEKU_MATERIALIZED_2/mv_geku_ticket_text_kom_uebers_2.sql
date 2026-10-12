CREATE OR REPLACE VIEW dbp_msi_view_geku_materialized.mv_geku_ticket_text_kom_uebers_2 (geku_ticket_id,
textart_id, text) AS -- ,CAST(TEXT AS STRING)
 SELECT geku_ticket_id,
 textart_id,
 CAST(text AS STRING) AS text
FROM dbp_view.v_geku_ticket_text_2
WHERE textart_id = 2;