--==============================================================
-- Table: besch_faktura_kondit
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besch_faktura_kondit
   generated from Powerdesigner on Dienstag, 20. September 2022 16:47:53
*/ --------------------------------------------------------------------------------


--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_faktura_kondit (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant 1 steht im DWH fuer Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
faktura_beleg_id INTEGER NOT NULL
OPTIONS(description='Das Feld enthaelt die Beleg ID der der Faktura und dient der eindeutigen Identifikation der Fakturabelege.Aus vbeln. Oder generiert aus mjahr+ mbeln'),
faktura_beleg_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Das Feld enthaelt die Nummer einer Fakturaposition und dient zusammen mit der Fakturabeleg ID  der eindeutigen Identifikation der Fakturabelegpositionen. Aus posnr'),
beleg_kondition_id INTEGER NOT NULL OPTIONS(description='Nummer der Belegkondition aus knumv'),
kondition_schl_id STRING(4) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des Konditionsschlüssels aus kschl'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
kondition_wert NUMERIC(18,2) NOT NULL
OPTIONS(description='Wert der Kondition zu GLD in Fakturawaehrung (Euro) aus kwert'),
kappl STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Applikation aus kappl, z.Bsp. V für Vertrieb'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, faktura_beleg_id, faktura_beleg_pos_id, beleg_kondition_id) NOT ENFORCED
) CLUSTER BY mandant_id
OPTIONS(description='WWC - Hier sind die Konditionssaetze zu den Fakturen hinterlegt (nur für Exportvorgaenge). Quelle ist konv');