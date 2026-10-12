CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_TICKET_TEXT_ERG_UEBERS_2
(
geku_ticket_id
,textart_id
,TEXT
)
AS
   SELECT
   geku_ticket_id
   , textart_id
   , CAST (TEXT AS VARCHAR(5000)) AS TEXT
   -- ,CAST(TEXT AS CLOB(10000))
   FROM dbp_view.v_geku_ticket_text_2
   WHERE textart_id = 4;