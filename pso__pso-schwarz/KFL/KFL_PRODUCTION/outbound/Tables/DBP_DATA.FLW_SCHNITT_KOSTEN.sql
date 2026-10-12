--==============================================================
-- Table: flw_schnitt_kosten
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_schnitt_kosten
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_schnitt_kosten (
schnitt_id INTEGER NOT NULL OPTIONS(description='Eindeutige Nummer des Schnitts aus cutnr'),
sek_schl_typ_id STRING(1) NOT NULL OPTIONS(description='Typ des Sekundärschlüssels aus sctyp'),
sek_schl_id INTEGER NOT NULL OPTIONS(description='ID des Sekundärschlüssels aus sckey'),
input_typ_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Input Typ aus itypc. S steht für Summe'),
kosten_block_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kostenblock aus costb'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
fertig_einzel_kosten_kg NUMERIC(18,4) DEFAULT 0 NOT NULL
OPTIONS(description='interne Var. Kosten (Preis) pro kg aus ivarp'),
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (schnitt_id, sek_schl_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Schnitt Kopf Kosten aus cutkc - MULTISET');