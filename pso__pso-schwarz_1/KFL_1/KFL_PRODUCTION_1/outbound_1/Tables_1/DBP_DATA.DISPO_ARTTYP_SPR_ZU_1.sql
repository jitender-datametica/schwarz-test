--==============================================================
-- Table: dispo_arttyp_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: dispo_arttyp_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:47 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.dispo_arttyp_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1    '),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprachschlüssel'),
dispo_arttyp_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Typ  '),
dispo_arttyp_bez STRING(60) OPTIONS(description='Typ Bez.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id, dispo_arttyp_id) NOT ENFORCED
) OPTIONS(description='VZ-Dispo Artikeltyp Texte (DD07V Domname ZSCM_DC_ARTTYPE)');