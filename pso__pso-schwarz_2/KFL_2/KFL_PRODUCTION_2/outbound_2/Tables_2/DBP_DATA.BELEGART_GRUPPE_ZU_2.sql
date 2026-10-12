--==============================================================
-- Table: belegart_gruppe_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belegart_gruppe_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belegart_gruppe_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des Mandanten im DWH; Deutschland entspricht Mandant_ID = 1;'),
system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Die System ID kennzeichnet das Quellsystem der Daten (z. B. SAP PR1).'),
belegart_gruppe_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Gruppierung über die Belegarten (fortlaufende Nummer)'),
belegart_id STRING(2) NOT NULL
OPTIONS(description='Eindeutiger Schluessel fuer die Belegarten bei den Eingangsrechnungen (z. B. Rechnung, Gutschrit, Bela, Rbela, usw.).'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (system_id, belegart_gruppe_id, belegart_id, mandant_id) NOT ENFORCED
) OPTIONS(description='RPW - DATA - Zuordnung Belegart zu Beleggruppe             ');