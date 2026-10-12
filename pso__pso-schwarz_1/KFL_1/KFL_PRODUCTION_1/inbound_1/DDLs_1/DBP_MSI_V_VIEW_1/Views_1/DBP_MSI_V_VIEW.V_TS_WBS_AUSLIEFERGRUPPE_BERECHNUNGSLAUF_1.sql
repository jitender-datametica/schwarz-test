CREATE OR REPLACE VIEW DBP_MSI_V_VIEW.V_TS_WBS_AUSLIEFERGRUPPE_BERECHNUNGSLAUF_1 (
   mandant_id                               COMMENT 'Mandant_1'
  ,ausliefergruppe_id                       COMMENT 'Ausliefergruppe'
  ,berechnungsprozess_id                    COMMENT 'ID des Berechnungsprozesses. 1 = Initiale Belieferung,  2 = Replenishment'
  ,berechnungslauf_nr                       COMMENT 'Nummer des Berechnungslaufs für die Berechnungsprozess.'
  ,zeitslot_id                              COMMENT 'ID des Zeitslots für die Kalkulation und Bestellung von zusätzlicher Werbeware. Mandanten haben nicht unbedingt gleiche Zeitslots.'
)
COMMENT = 'SCM-WBS - Die Tabelle enthält die Attribute (z. B. Zeitslot_ID) der verschiedenen Berechnungsläufe (erster, zweiter usw.) für die verschiedenen Berechnungsprozesse (z. B. Initiale Belieferung). Der Inhalt wird von Transaktion Services gepflegt.'
 AS 
    SELECT 
        mandant_id,
        ausliefergruppe_id,
        berechnungsprozess_id,
        berechnungslauf_nr,
        zeitslot_id

FROM DBP_MSI_DATA.TS_WBS_AUSLIEFERGRUPPE_BERECHNUNGSLAUF_1 ;