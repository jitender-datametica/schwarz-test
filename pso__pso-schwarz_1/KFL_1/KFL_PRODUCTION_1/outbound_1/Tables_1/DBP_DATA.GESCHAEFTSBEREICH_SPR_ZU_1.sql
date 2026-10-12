--==============================================================
-- Table: geschaeftsbereich_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: geschaeftsbereich_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.geschaeftsbereich_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
geschaeftsbereich_id STRING(4) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Der Geschaeftsbereich ist eine_1 interne Organisationseinheit, fuer den eine_1 interne Bilanz sowie Gewinn- und Verlustrechnung erstellt werden kann. Aus gsber'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
geschaeftsbereich_bez STRING(30) COLLATE 'und:ci',
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='IMS - Diese Tabelle enthaelt die sprachabhaengigen Bezeichnungen der Geschäftsbereiche');