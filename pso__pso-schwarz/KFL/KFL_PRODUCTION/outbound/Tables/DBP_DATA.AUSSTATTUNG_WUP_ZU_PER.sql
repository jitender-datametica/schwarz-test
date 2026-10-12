--==============================================================
-- Table: ausstattung_wup_zu_per
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ausstattung_wup_zu_per
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ausstattung_wup_zu_per (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
wup_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Marktnummer aus t001w.werks'),
ausstattung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID des Ausstattungsmerkmals. Wird im DWH vergeben'),
dat_von DATE NOT NULL OPTIONS(description='Datum, ab dem der Satz Gültigkeit hat'),
dat_bis DATE NOT NULL OPTIONS(description='Ende der Gültigkeitsperiode. Format JJJJ-MM-TT            '),
anzahl BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Anzahl, z.Bsp. Anzahl Kundenkassen'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wup_id, ausstattung_id, dat_von) NOT ENFORCED
) OPTIONS(description='VIS - Welche Ausstattung besitzt ein Markt in welcher Anzahl');