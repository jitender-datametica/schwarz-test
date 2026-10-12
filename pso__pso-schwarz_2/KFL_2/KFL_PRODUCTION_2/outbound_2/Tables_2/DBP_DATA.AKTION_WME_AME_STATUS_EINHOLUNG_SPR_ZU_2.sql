--==============================================================
-- Table: aktion_wme_ame_status_einholung_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_wme_ame_status_einholung_spr_zu_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aktion_wme_ame_status_einholung_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
status_einholung_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID Status_2 der Einholung'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='DWH Sprach ID '),
status_einholung_bez STRING(80) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung Status_2 der Einholung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, status_einholung_id, spr_id) NOT ENFORCED
)
OPTIONS(description='VIS - Sprachabhängige Bezeichnungen zum Status_2 Einholung der Werbemengen / Allg. Mengeneinholung - manuelle Beladung');