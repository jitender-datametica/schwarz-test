CREATE OR REPLACE VIEW DBP_VIEW.V_L_KAMPAGNE_NACHRICHT_AKTION_TYP_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,nachricht_aktion_typ_id                  COMMENT 'ID, die die Art_2 der ausgeführten Aktion_2 angibt, z. B. 1 = Gesendet 2 = Blockiert 3 = Zugestellt 4 = Bounced 5 = Geöffnet 6 = Feedback Loop 7 = Link geklicked, etc..'
)
COMMENT = 'Die Tabelle enthält die Referenzinformationen zu den verschiedenen Aktionstypen, die im Zusammenhang mit einer versendeten Nachricht auftreten können, z. B. Gesendet, Blockiert, Zugestellt, Geöffnet, usw.'
 AS 
    SELECT 
        mandant_id,
        nachricht_aktion_typ_id

FROM DBP_DATA.L_KAMPAGNE_NACHRICHT_AKTION_TYP_2 ;