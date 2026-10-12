CREATE OR REPLACE VIEW DBP_VIEW.V_PROMOTION_EVENT (
   mandant_id                               COMMENT 'Mandant im DWH'
  ,promotion_event_id                       COMMENT 'ID des Promotion Events.'
  ,dat_promotion_event_gueltig_von          COMMENT 'Datum, ab dem das Promotion Event gültig ist.'
  ,dat_promotion_event_gueltig_bis          COMMENT 'Datum, bis das Promotion Event gültig ist.'
  ,werbemittel_id                           COMMENT 'ID des Werbemittels'
  ,werbemittelkanal_id                      COMMENT 'ID des Werbemittelkanals'
  ,werbethema_id                            COMMENT 'ID des Werbethemas'
  ,werbeflaechenthema_cd                    COMMENT 'Code des Werbeflaechenthemas'
)
COMMENT = 'Tabelle enthält Stammdaten zum promotion event. Ein Promotion Event kann mehrere Angebote zu einer Werbung über einem Werbemittel zusammenfassen.'
 AS 
    SELECT 
        mandant_id,
        promotion_event_id,
        dat_promotion_event_gueltig_von,
        dat_promotion_event_gueltig_bis,
        werbemittel_id,
        werbemittelkanal_id,
        werbethema_id,
        werbeflaechenthema_cd

FROM DBP_DATA.PROMOTION_EVENT ;