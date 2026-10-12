--==============================================================
-- Table: ts_wbs_ausliefergruppe_berechnungslauf_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_wbs_ausliefergruppe_berechnungslauf_2
   generated from Powerdesigner on Samstag, 22. Februar 2025 21:27:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ts_wbs_ausliefergruppe_berechnungslauf_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2'),
ausliefergruppe_id STRING(10) NOT NULL OPTIONS(description='Ausliefergruppe'),
berechnungsprozess_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Berechnungsprozesses. 1 = Initiale Belieferung,  2 = Replenishment'),
berechnungslauf_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Nummer des Berechnungslaufs für die Berechnungsprozess.'),
zeitslot_id BIGNUMERIC(38,0)
OPTIONS(description='ID des Zeitslots für die Kalkulation und Bestellung von zusätzlicher Werbeware. Mandanten haben nicht unbedingt gleiche Zeitslots.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, ausliefergruppe_id, berechnungsprozess_id, berechnungslauf_nr) NOT ENFORCED
)
OPTIONS(description='SCM-WBS - Die Tabelle enthält die Attribute (z. B. Zeitslot_ID) der verschiedenen Berechnungsläufe (erster, zweiter usw.) für die verschiedenen Berechnungsprozesse (z. B. Initiale Belieferung). Der Inhalt wird von Transaktion Services gepflegt.');