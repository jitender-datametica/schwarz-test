--==============================================================
-- Table: in_messbeleg_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_messbeleg_1
   generated from Powerdesigner on Freitag, 19. August 2022 08:18:38
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_messbeleg_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
messbeleg_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Messbeleg'),
auftrag_id STRING(20) COLLATE 'und:ci' OPTIONS(description='Auftragsnummer aus aufnr'),
auftrag_nr STRING(22) OPTIONS(description='Objektnummer des Auftrags (Originalwert)'),
messpunkt_id BIGNUMERIC(38,0)
OPTIONS(description='Messpunkt/Measuring point. In Plant Maintenance, measuring points are located on technical objects, in other words, on pieces of equipment or functional locations.'),
dat_messung DATE OPTIONS(description='Datum der Messung'),
messwert BIGNUMERIC(38,16) OPTIONS(description='Messwert in Erfassungseinheit'),
menge_einh_id_messung STRING(3) OPTIONS(description='Messeinheit bei Belegerfassung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, messbeleg_id) NOT ENFORCED
) OPTIONS(description='Messbelege aus SAP Industry (Tabelle IMRG) mit Bezug zum Auftrag (z. B. Instandhaltung/Wartung)');