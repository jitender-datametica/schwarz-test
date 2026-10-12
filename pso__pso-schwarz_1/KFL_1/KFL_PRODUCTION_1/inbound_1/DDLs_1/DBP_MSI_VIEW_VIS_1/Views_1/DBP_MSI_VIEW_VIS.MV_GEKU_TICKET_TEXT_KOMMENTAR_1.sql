CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_GEKU_TICKET_TEXT_KOMMENTAR_1
(
geku_ticket_id
,textart_id
,TEXT
)
AS
   SELECT
   geku_ticket_id, textart_id, TEXT
   FROM dbp_view.v_geku_ticket_text_1
   WHERE textart_id = 1;