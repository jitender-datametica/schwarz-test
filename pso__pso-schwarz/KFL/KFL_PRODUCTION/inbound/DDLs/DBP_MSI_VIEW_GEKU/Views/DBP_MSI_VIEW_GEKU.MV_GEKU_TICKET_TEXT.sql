CREATE OR REPLACE VIEW DBP_MSI_VIEW_GEKU.MV_GEKU_TICKET_TEXT
(
geku_ticket_id
,textart_id
,dat_start
,dat_ende
,TEXT
)
AS
   SELECT
   t1.geku_ticket_id
   , t1.textart_id
   , t2.dat_start
   , t2.dat_ende
   , t1.TEXT
   FROM dbp_view.v_geku_ticket_text t1

   INNER JOIN dbp_view.v_geku_ticket t2
   ON t1.geku_ticket_id = t2.geku_ticket_id;