CREATE OR REPLACE VIEW DBP_VIEW.V_L_ANGEBOT_ATTRIBUT_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH'
  ,angebot_attribut_id                      COMMENT 'ID des Attributs.'
)
COMMENT = 'Enthält mögliche Attribute / Charakteristiken die einem Angebot_1 zusätzlich noch hinzugefügt werden können. Diese zusätzlichen Attribute können dabei sehr unterscheidlich sein und beispielsweise Informationen zu den Bestellmengen, Platzierung in der Filiale, Darstellung im Werbemittel, etc. enthalten.'
 AS 
    SELECT 
        mandant_id,
        angebot_attribut_id
FROM DBP_DATA.L_ANGEBOT_ATTRIBUT_1 ;