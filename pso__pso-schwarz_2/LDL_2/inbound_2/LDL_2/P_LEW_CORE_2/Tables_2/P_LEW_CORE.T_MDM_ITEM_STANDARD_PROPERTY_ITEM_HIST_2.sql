/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_standard_property_item_hist_2
   generated from Powerdesigner on Dienstag, 25. November 2025 15:35:47
*/ --------------------------------------------------------------------------------

CREATE TABLE P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST_2 (
   mdm_item_sid                        NUMBER(38,0)     NOT NULL COMMENT 'foreign key NFPO item_2 instance
            CBX: LDL_ITEM_CERTIFICATION.ITEM_ID',
   mdm_item_standard_property_cd       VARCHAR(100)     NOT NULL COMMENT 'Code of the standardized item_2 properties.
            CBX: for TX class properties: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_TX
            for HG class properties: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_HG',
   mdm_item_standard_property_class_cd VARCHAR(100)     NOT NULL COMMENT 'Class of the standardized item_2 properties: So far "TX" for textile item_2 properties and "HG" for hard goods item_2 properties.
            CBX: "TX" if from source column: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_TX
            "HG" if from source column: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_HG',
   deleted_fg                          NUMBER(38,0)     NOT NULL COMMENT 'Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.',
   dwh_valid_from                      DATE             NOT NULL COMMENT 'Begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).',
   dwh_valid_to                        DATE             NOT NULL COMMENT 'End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).',
   client_id                           NUMBER(38,0)     NOT NULL COMMENT 'Technical column required by the used ETL framework. Static 7 for all rows.',
   dwh_load_id                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier of the last run which inserted or updated the record. -1 means manually inserted.',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.',   
   CONSTRAINT PK_T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST PRIMARY KEY (mdm_item_sid, mdm_item_standard_property_class_cd, mdm_item_standard_property_cd, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'The table contains information about standardized additional properties of NFPO items.
             CBX: LDL_ITEM_CERTIFICATION';
