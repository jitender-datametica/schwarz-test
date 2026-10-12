--==============================================================
-- Table: sok_abteilung_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: sok_abteilung_spr_zu
   generated from Powerdesigner on Donnerstag, 21. Dezember 2023 13:27:11
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sok_abteilung_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH.'),
sok_abteilung_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='ID der SOK Abteilung. Fasst die SOK Fima Bausteine zu einer übergeordneten Berichtshierarchie-Ebene zusammen.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
sok_abteilung_bez STRING(100) OPTIONS(description='Bezeichnung der SOK Abteilung.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, sok_abteilung_id, spr_id) NOT ENFORCED
) OPTIONS(description='Bezeichnungen der SOK Abteilung in unterschiedliche Sprachen.');