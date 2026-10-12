--==============================================================
-- Table: flw_meldungsart_werk_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_meldungsart_werk_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_meldungsart_werk_zu_1 (
werk_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
meldungsart_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der Meldungsart aus qmart'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (werk_id, mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - QM: Zuordnung Werk zu Qualitätsmeldungsart aus zfw_wrk_qmeldung');