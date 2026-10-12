--==============================================================
-- Table: l_qa_deklarationsfehler_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_qa_deklarationsfehler_2
   generated from Powerdesigner on Mittwoch, 28. Februar 2024 10:48:43
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_qa_deklarationsfehler_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
qa_deklarationsfehler_id STRING(3) NOT NULL OPTIONS(description='QA-Deklarationsfehler (, z. B. 002 = Etikett fehlt)'),
aktiv_fg BIGNUMERIC(38,0) OPTIONS(description='Aktiv, d. h. wird bei Wareneingang geprüft'),
pflanzen_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Fehlercode für Pflanzen relevant (sonst nur O&G)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, qa_deklarationsfehler_id) NOT ENFORCED
) OPTIONS(description='Lookup für QA-Deklarationsfehler Codes, z. B. 002 = Etikett fehlt');