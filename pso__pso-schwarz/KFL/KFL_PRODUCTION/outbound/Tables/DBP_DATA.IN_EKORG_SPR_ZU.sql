--==============================================================
-- Table: in_ekorg_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_ekorg_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_ekorg_spr_zu (
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
einkaufsorganisation_bez STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung der Einkaufsorganisation aus ekotx'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (einkaufsorganisation_id, spr_id, mandant_id) NOT ENFORCED
) OPTIONS(description='BIS - Sprachabhängige Bezeichnung der Einkaufsorganisation aus t024e Industrie');