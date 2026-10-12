--==============================================================
-- Table: qa_deklarationsfehler_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: qa_deklarationsfehler_spr_zu_2
   generated from Powerdesigner on Mittwoch, 28. Februar 2024 10:49:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.qa_deklarationsfehler_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
qa_deklarationsfehler_id STRING(3) NOT NULL
OPTIONS(description='ID der QA-Deklarationsfehler (, z. B. 002 = Etikett fehlt)'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
qa_deklarationsfehler_bez STRING(50) OPTIONS(description='Bezeichnung der QA-Deklarationsfehler.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, qa_deklarationsfehler_id, spr_id) NOT ENFORCED
) OPTIONS(description='Texte für QA-Deklarationsfehler Codes, z. B. 002 = Etikett fehlt');