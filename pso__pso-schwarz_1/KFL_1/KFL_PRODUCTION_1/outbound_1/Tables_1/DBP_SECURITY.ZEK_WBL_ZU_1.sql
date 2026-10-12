--==============================================================
-- Table: zek_wbl_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: zek_wbl_zu_1
   generated from Powerdesigner on Donnerstag, 31. August 2023 10:18:10
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_security.zek_wbl_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
zek_id STRING(3) NOT NULL
OPTIONS(description='Zentraleinkäufer - ID: Diese ID ist nicht mit der Mitarbeiter - ID identisch'),
wbl_id BIGNUMERIC(38,0) OPTIONS(description='Warenbereichsleiter ID'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, zek_id) NOT ENFORCED
)
OPTIONS(description='EK-INTEGER  - Zuordnungstabelle Zentraleinkäufer zu WBL_1 (EKL - Einkaufsleiter) - wird manuell über MSI (TAS) befüllt');