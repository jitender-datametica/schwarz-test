create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU_MATERIALIZED.MV_GEKU_TICKET_TEXT_2(
	GEKU_TICKET_ID,
	TEXTART_ID,
	DAT_START,
	DAT_ENDE,
	TEXT
) as
   SELECT
   t1.geku_ticket_id
   , t1.textart_id
   , t2.dat_start
   , t2.dat_ende
   , t1.TEXT
   FROM dbp_view.v_geku_ticket_text_2 t1_2

   INNER JOIN dbp_view.v_geku_ticket_2 t2
   ON t1.geku_ticket_id = t2.geku_ticket_id;
