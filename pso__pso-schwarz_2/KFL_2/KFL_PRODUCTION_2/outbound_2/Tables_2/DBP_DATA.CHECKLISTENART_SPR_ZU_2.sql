--==============================================================
-- Table: checklistenart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: checklistenart_spr_zu_2
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.checklistenart_spr_zu_2 (
checklistenart_id STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Eindeutige ID des Checklistentyps, z.Bsp. CL1 aus cpr_chktyp'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Referenz zu der Tabelle spr_2 fuer jede DWH Sprache = 1.'),
cpr_checkliste_bez STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Sprachabhängige Bezeichnung der Checklistenart, z.Bsp. Checklist Header Type 1'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id) NOT ENFORCED
) OPTIONS(description='IOS - Sprachabhängige Bezeichnung der Checklistenart');