CREATE OR REPLACE VIEW DBP_VIEW.V_ANGEBOT_PROMOTION_EVENT_ZU_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,angebot_nr                               COMMENT 'Numerische oder Alphanumerische Nummer des Angebots'
  ,promotion_event_id                       COMMENT 'ID des Promotion Events.'
)
COMMENT = 'Beziehungstabelle zwischen dem Promotion Event und den Angeboten. Ein Angebot_1 kann einem oder mehreren Promotion Events zugeordnet sein. Ein Promotion Event besteht aus einem oder mehreren Angeboten.'
 AS 
    SELECT 
        mandant_id,
        angebot_nr,
        promotion_event_id

FROM DBP_DATA.ANGEBOT_PROMOTION_EVENT_ZU_1 ;