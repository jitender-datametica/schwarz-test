--==============================================================
-- Table: eps_layout_groesse_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_layout_groesse_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.eps_layout_groesse_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
layout_groesse_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Layoutgröße; (z.B. 1 = Mini, 9 = A4, …)'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
layout_groesse_bez STRING(50) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung der Layoutgröße; (z.B. 1 = Mini, 9 = A4, …)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, layout_groesse_id, spr_id) NOT ENFORCED
) OPTIONS(description='VIS - Sprachabhängige Bezeichnungen der Layoutgröße aus EPS (z.B. 1 = Mini, 9 = A4, …)');