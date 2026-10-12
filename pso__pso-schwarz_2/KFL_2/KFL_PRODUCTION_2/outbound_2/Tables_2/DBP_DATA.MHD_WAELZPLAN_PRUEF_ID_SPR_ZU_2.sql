--==============================================================
-- Table: mhd_waelzplan_pruef_id_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: mhd_waelzplan_pruef_id_spr_zu_2
   generated from Powerdesigner on Mittwoch, 14. Dezember 2022 15:44:58
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mhd_waelzplan_pruef_id_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
waelzplan_pruef_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Prüf-ID für den Wälzplan.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
waelzplan_pruef_bez STRING(200) OPTIONS(description='Beschreibung der Prüf-ID.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, waelzplan_pruef_id) NOT ENFORCED
) OPTIONS(description='Lookuptabelle für die Übersetzungen der Prüf-IDs für den Wälzplan.');