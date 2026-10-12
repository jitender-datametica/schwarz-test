--==============================================================
-- Table: eps_druck_anlass_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_druck_anlass_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.eps_druck_anlass_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
druck_anlass_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='Anlass des Drucks; (z.B. PE (Preiserhöhung).'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
druck_anlass_bez STRING(50) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Sprachabhängige Bezeichnung des Druckanlasses'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
)
OPTIONS(description='VIS - Sprachabhängige Bezeichnungen der Druckanlässe aus EPS (z.B. PE = Preiserhöhung) - manuelle Beladung');