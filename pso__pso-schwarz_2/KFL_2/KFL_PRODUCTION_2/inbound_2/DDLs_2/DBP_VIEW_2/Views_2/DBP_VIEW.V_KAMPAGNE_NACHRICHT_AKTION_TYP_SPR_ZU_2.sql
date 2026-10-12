CREATE OR REPLACE VIEW DBP_VIEW.V_KAMPAGNE_NACHRICHT_AKTION_TYP_SPR_ZU_2 (
   mandant_id                               COMMENT 'Mandant_2 im DWH.'
  ,nachricht_aktion_typ_id                  COMMENT 'ID, die die Art_2 der ausgeführten Aktion_2 angibt.'
  ,spr_id                                   COMMENT 'ID der DWH-Sprache, z.B. 22 = Deutsch, 24 = Englisch, etc.'
  ,nachricht_aktion_typ_bez                 COMMENT 'Bezeichnung des Absendungaktionen in unterschiedlichen Sprachen, z. B. Gesendet, Blockiert, Zugestellt, Bounced, Geöffnet, Feedback Loop, Link geklicked, usw.'
)
COMMENT = 'Sprachabhängige Bezeichnungen der Aktionstypen für Marketingkampagnen - manuell versorgt.'
 AS 
    SELECT 
        mandant_id,
        nachricht_aktion_typ_id,
        spr_id,
        nachricht_aktion_typ_bez

FROM DBP_DATA.KAMPAGNE_NACHRICHT_AKTION_TYP_SPR_ZU_2 ;