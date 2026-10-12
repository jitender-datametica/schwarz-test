--==============================================================
-- Table: ts_wbs_ausliefergruppe_berechnungslauf
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_ausliefergruppe_berechnungslauf
   generated from Powerdesigner on Samstag, 22. Februar 2025 21:27:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_DATA.TS_WBS_AUSLIEFERGRUPPE_BERECHNUNGSLAUF (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant',
   ausliefergruppe_id                  VARCHAR(10)      NOT NULL COMMENT 'Ausliefergruppe',
   berechnungsprozess_id               INTEGER     NOT NULL COMMENT 'ID des Berechnungsprozesses. 1 = Initiale Belieferung,  2 = Replenishment',
   berechnungslauf_nr                  INTEGER     NOT NULL COMMENT 'Nummer des Berechnungslaufs für die Berechnungsprozess.',
   zeitslot_id                         INTEGER     COMMENT 'ID des Zeitslots für die Kalkulation und Bestellung von zusätzlicher Werbeware. Mandanten haben nicht unbedingt gleiche Zeitslots.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_WBS_AUSLIEFERGRUPPE_BERECHNUNGSLAUF PRIMARY KEY (mandant_id, ausliefergruppe_id, berechnungsprozess_id, berechnungslauf_nr) NOT ENFORCED
)  COMMENT = 'SCM-WBS - Die Tabelle enthält die Attribute (z. B. Zeitslot_ID) der verschiedenen Berechnungsläufe (erster, zweiter usw.) für die verschiedenen Berechnungsprozesse (z. B. Initiale Belieferung). Der Inhalt wird von Transaktion Services gepflegt.';
