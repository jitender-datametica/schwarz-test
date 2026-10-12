CREATE OR REPLACE VIEW DBP_VIEW.V_CRM_HOTLINE_BEREICH_SPR_ZU_1 (
   mandant_id                               COMMENT 'Mandant_1 im DWH.'
  ,crm_hotline_bereich_id                   COMMENT 'ID des Bereichs innerhalb der CRM-Hotline, an den der Anruf zugestellt wurde. Dieser Wert kategorisiert, welche Abteilung oder welches Team den Anruf entgegengenommen hat.'
  ,spr_id                                   COMMENT 'ID der Sprache'
  ,crm_hotline_bereich_bez                  COMMENT 'Bezeichnung des Bereichs innerhalb der CRM-Hotline.'
)
COMMENT = 'Diese Tabelle enthält die sprachabhängigen Bezeichnungen der CRM-Hotline-Bereiche. Sie wird manuell befüllt.'
 AS 
    SELECT 
        mandant_id,
        crm_hotline_bereich_id,
        spr_id,
        crm_hotline_bereich_bez

FROM DBP_DATA.CRM_HOTLINE_BEREICH_SPR_ZU_1 ;