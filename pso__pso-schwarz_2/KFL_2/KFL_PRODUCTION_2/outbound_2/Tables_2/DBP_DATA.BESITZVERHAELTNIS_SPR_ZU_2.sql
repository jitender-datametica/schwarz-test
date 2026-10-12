--==============================================================
-- Table: besitzverhaeltnis_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: besitzverhaeltnis_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besitzverhaeltnis_spr_zu_2 (
besitzverhaeltnis_id STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des Besitzverhältnis (z.B. 1 = Miete)'),
besitzverhaeltnis_bez STRING(60) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung des Besitzverhältnis'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='RPM - Sprachtabelle Besitzverhältnis - SAP P85 - /RPM/ITEM_D - ZZPM_BESITZVERH Text');