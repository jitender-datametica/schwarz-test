--==============================================================
-- Table: ims_mamo_qualifier
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ims_mamo_qualifier
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMS_MAMO_QUALIFIER (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   qualifier_id                        NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID eines Qualifiers (Surrogate Key DWH - Basis Qualifier Bezeichnung (Upload Fachbereich))',
   qualifier_bez                       VARCHAR(50)      COLLATE 'en-ci',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMS_MAMO_QUALIFIER PRIMARY KEY (mandant_id, qualifier_id) NOT ENFORCED
)  COMMENT = 'IMS - Lookup Marktmodernisierung Qualifier - manueller Upload via Sharepoint';
