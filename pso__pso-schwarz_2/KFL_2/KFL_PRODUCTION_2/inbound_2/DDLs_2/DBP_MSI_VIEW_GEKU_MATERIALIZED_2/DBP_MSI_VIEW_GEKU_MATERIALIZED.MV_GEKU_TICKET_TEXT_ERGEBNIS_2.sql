create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_GEKU_TICKET_TEXT_ERGEBNIS_2(
	GEKU_TICKET_ID,
	TEXTART_ID,
	TEXT
) as
   SELECT
   geku_ticket_id
   , textart_id
   , CAST (TEXT AS VARCHAR(10000)) AS TEXT
   -- ,CAST(TEXT AS CLOB(10000))
   FROM dbp_view.v_geku_ticket_text_2
   WHERE textart_id = 3;
