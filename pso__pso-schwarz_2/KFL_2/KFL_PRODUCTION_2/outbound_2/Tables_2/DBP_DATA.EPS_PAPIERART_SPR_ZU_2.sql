--==============================================================
-- Table: eps_papierart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: eps_papierart_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.eps_papierart_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
papierart_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der Papierart; (z.B. 3 = weiss A4, 200 = neon-orange A4, …)'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
papierart_bez STRING(60) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung der Papierart; (z.B. 3 = weiss A4, 200 = neon-orange A4, …)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, papierart_id, spr_id) NOT ENFORCED
)
OPTIONS(description='VIS - Sprachabhängige Bezeichnungen der Papierarten aus EPS (z.B. 3 = weiss A4, 200 = neon-orange A4, …) ');