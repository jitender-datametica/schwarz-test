--==============================================================
-- Table: sok_fima_baustein_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: sok_fima_baustein_spr_zu_1
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 12:08:05
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sok_fima_baustein_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
sok_fima_baustein_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID des SOK FIMA Baustein - im DWH generierter numerischer Schlüssel. Fasst mehrere SOK Kategorien zu einer übergeordneten Hierarchie-Ebene zusammen.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache.'),
sok_fima_baustein_bez STRING(100) OPTIONS(description='Bezeichnung des SOK FIMA Baustein.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, sok_fima_baustein_id, spr_id) NOT ENFORCED
) OPTIONS(description='Bezeichnungen der SOK FIMA Bausteine in unterschiedlichen Sprachen.');