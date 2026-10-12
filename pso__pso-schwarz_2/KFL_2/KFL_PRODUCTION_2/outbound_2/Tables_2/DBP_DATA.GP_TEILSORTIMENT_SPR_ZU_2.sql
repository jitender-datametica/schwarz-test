--==============================================================
-- Table: gp_teilsortiment_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gp_teilsortiment_spr_zu_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gp_teilsortiment_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
gp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftspartner - ID (Lieferanten - ID)'),
gp_teilsortiment_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Teilsortiment aus SAP ltsnr'),
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Für verschiedene Unternehmensbereiche - Warenhandel, Fleischwerk - existieren unterschiedliche Einkaufsorganisationen'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache ID'),
gp_teilsortiment_bez STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Sprachabhängige Kurzbezeichnung aus ltsbz'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, gp_id, einkaufsorganisation_id, spr_id) NOT ENFORCED
)
OPTIONS(description='AIS_KMO- Sprachabhängige Bezeichnungen der Teilsortimente pro Lieferant aus der Quelle SAP wyt1t_2');