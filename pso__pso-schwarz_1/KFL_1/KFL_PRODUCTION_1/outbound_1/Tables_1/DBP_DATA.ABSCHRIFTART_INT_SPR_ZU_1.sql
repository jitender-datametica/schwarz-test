--==============================================================
-- Table: abschriftart_int_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: abschriftart_int_spr_zu_1
   generated from Powerdesigner on Wednesday, January 31, 2024 2:33:01 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.abschriftart_int_spr_zu_1 (
abschriftart_int_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID Einheitliche Abschriftart KL international (z.B. -1=Werbeabschriften)'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
abschriftart_int_bez STRING(40) COLLATE 'und:ci' DEFAULT ' ' NOT NULL
OPTIONS(description='Bezeichnung Einheitliche Abschriftart KL international'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (abschriftart_int_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS - Sprach-Tabelle für Einheitliche Abschriftenarten KL international');