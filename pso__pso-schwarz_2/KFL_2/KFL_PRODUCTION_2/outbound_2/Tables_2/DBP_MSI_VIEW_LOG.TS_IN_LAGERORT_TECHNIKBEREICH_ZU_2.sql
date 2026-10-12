--==============================================================
-- Table: ts_in_lagerort_technikbereich_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_in_lagerort_technikbereich_zu_2
   generated from Powerdesigner on Freitag, 19. August 2022 12:18:29
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_log.ts_in_lagerort_technikbereich_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2'),
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Werk'),
in_lagerort_id STRING(4) NOT NULL OPTIONS(description='Lagerort'),
technikbereich_bez STRING(100) OPTIONS(description='Bezeichnung Technikbereich'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, werk_id, in_lagerort_id) NOT ENFORCED
)
OPTIONS(description='Mappingtabelle SAP Industry Lagerort zu Technikbereich (z. B. FFZ/Flurförderfahrzeuge) - wird durch Transaction Services Dokument versorgt');