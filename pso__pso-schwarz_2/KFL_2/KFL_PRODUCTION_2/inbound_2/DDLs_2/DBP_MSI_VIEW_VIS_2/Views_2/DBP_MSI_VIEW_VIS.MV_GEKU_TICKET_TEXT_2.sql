CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_TICKET_TEXT_2
(
geku_ticket_id
,textart_id
,dat_start
,dat_ende
,mandant_id
,nb_id
,wup_id
,TEXT
)
AS
   SELECT
   t1.geku_ticket_id, t1.textart_id, t2.dat_start, t2.dat_ende, t2.mandant_id_wup  AS mandant_id, t2.nb_id, t2.wup_id, t1.TEXT
   FROM dbp_view.v_geku_ticket_text_2 t1_2
   INNER JOIN dbp_view.v_geku_ticket_2 t2
   ON t1.geku_ticket_id = t2.geku_ticket_id
   ;