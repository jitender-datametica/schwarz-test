create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_GEKU_TICKET_TEXT_KOM_UEBERS(
	GEKU_TICKET_ID,
	TEXTART_ID,
	TEXT
) as
   SELECT
   geku_ticket_id
   , textart_id
   , CAST (TEXT AS VARCHAR(5000)) AS TEXT
   -- ,CAST(TEXT AS CLOB(10000))
   FROM dbp_view.v_geku_ticket_text
   WHERE textart_id = 2;