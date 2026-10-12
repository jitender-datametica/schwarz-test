--==============================================================
-- Table: in_instandhaltung_objekt_qual
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_instandhaltung_objekt_qual
   generated from Powerdesigner on Montag, 11. April 2022 11:44:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_instandhaltung_objekt_qual (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
qual_meldung_id INTEGER NOT NULL OPTIONS(description='ID der Qualitaetsmeldung aus qmnum'),
tp_objekt_id BIGNUMERIC(38,0) OPTIONS(description='Auspraegung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP'),
auftrag_id STRING(20) COLLATE 'und:ci' OPTIONS(description='Auftragsnummer aus aufnr'),
techn_platz_id STRING(30) COLLATE 'und:ci'
OPTIONS(description='Der technische Platz ist eine von Kaufland Facility Management verwaltete Einheit'),
dat_stoer_beginn DATE OPTIONS(description='Stoerungsbeginn (Datum)'),
cs_auftrag_prio BIGNUMERIC(38,0)
OPTIONS(description='Für die Auftragsart 4IHA ist bei PRIOK eine Priorität von 1, 2 oder 3 angegeben. Falls keine Priorität angegeben: Null. (cs = customer service)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (qual_meldung_id, mandant_id) NOT ENFORCED
)
OPTIONS(description='LIS - IND View VIQMEL, enthaelt Tabellen QMEL (Qualitaetsmeldung) und ILOA (Standort und Kontierung zum ICH-Objekt)');