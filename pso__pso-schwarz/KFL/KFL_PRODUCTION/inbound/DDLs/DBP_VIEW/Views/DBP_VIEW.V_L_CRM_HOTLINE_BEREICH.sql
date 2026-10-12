CREATE OR REPLACE VIEW DBP_VIEW.V_L_CRM_HOTLINE_BEREICH (
   mandant_id                               COMMENT 'Mandant im DWH.'
  ,crm_hotline_bereich_id                   COMMENT 'ID des Bereichs innerhalb der CRM-Hotline, an den der Anruf zugestellt wurde. Dieser Wert kategorisiert, welche Abteilung oder welches Team den Anruf entgegengenommen hat.'
)
COMMENT = 'Die Tabelle ist eine Lookup-Tabelle für die Bereiche bzw. Abteilungen der CRM-Hotline. Sie enthält eine Liste der Bereiche, an die Anrufe zugestellt werden und die Anrufe entgegennehmen, z.B. KCard, Kundenhotline, Schadenshotline oder Zentrale.Sie wird manuell befüllt.'
 AS 
    SELECT 
        mandant_id,
        crm_hotline_bereich_id

FROM DBP_DATA.L_CRM_HOTLINE_BEREICH ;