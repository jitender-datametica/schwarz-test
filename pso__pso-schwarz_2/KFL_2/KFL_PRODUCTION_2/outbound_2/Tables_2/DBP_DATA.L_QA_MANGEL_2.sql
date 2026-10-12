--==============================================================
-- Table: l_qa_mangel_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_qa_mangel_2
   generated from Powerdesigner on Mittwoch, 28. Februar 2024 10:49:19
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_qa_mangel_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
qa_mangel_id STRING(3) NOT NULL OPTIONS(description='QA-Mangel (z. B. 001 = Frischemangel)'),
pflanzen_fg BIGNUMERIC(38,0) OPTIONS(description='Flag: Fehlercode für Pflanzen relevant (sonst nur O&G)'),
qa_prio BIGNUMERIC(38,0) OPTIONS(description='Priorität für QS-Kontrolle'),
frischemangel_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: QA-Mangel ist ein Frischemangel (nicht: Schädlinge, mechanische Beschädigung etc.)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, qa_mangel_id) NOT ENFORCED
) OPTIONS(description='Lookup für QA-Mängel Codes, z. B. 001 = Frischemangel');