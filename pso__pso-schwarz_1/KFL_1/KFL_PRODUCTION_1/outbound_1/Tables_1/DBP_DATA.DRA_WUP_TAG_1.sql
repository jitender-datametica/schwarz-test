--==============================================================
-- Table: dra_wup_tag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: dra_wup_tag_1
   generated from Powerdesigner on Mittwoch, 7. September 2022 14:03:14
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.dra_wup_tag_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Nummer des Warenumschlagsplatzes'),
dat DATE NOT NULL OPTIONS(description='Datum, zu dem der Umsatz entstanden ist, im Format YYYY-MM_1-DD'),
betrag_dra NUMERIC(9,2) NOT NULL OPTIONS(description='gespendeter Betrag in Euro. Kann zwischen 0,01 und 0,10 liegen'),
anz_bon BIGNUMERIC(38,0) DEFAULT 0 NOT NULL OPTIONS(description='Anzahl der Bons zum Wert aus dem Schluessel'),
wrg_id STRING(3) OPTIONS(description='Kurzbezeichnung der Waehrung, z.Bsp. CZK, EUR'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, dat, betrag_dra) NOT ENFORCED
) OPTIONS(description='VIS - Hier werden die gespendeten Betraege der Aktion_1 "Deutschland rundet auf" hinterlegt');