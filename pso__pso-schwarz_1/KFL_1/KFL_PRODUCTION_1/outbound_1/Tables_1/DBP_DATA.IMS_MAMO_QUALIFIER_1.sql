--==============================================================
-- Table: ims_mamo_qualifier_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ims_mamo_qualifier_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ims_mamo_qualifier_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
qualifier_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Eindeutige ID eines Qualifiers (Surrogate Key DWH - Basis Qualifier Bezeichnung (Upload Fachbereich))'),
qualifier_bez STRING(50) COLLATE 'und:ci',
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, qualifier_id) NOT ENFORCED
) OPTIONS(description='IMS - Lookup Marktmodernisierung Qualifier - manueller Upload via Sharepoint');