--==============================================================
-- Table: qa_mangel_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: qa_mangel_spr_zu
   generated from Powerdesigner on Mittwoch, 28. Februar 2024 10:49:41
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.qa_mangel_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
qa_mangel_id STRING(3) NOT NULL OPTIONS(description='ID des QA-Mangel (z. B. 001 = Frischemangel)'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
qa_mangel_bez STRING(50) OPTIONS(description='Bezeichnung des QA-Mangel'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, qa_mangel_id, spr_id) NOT ENFORCED
) OPTIONS(description='Texte für QA-Mängel Codes, z. B. 001 = Frischemangel');