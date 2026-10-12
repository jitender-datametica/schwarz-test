/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_standard_property_item_hist
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ITEM_STANDARD_PROPERTY_ITEM_HIST DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Foreign Key NFPO ITEM INSTANCE.
            CBX: LDL_ITEM_CERTIFICATION.ITEM_ID
            LDL: P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST.MDM_ITEM_SID',
   nfpo_item_standard_property_cd      VARCHAR(100)     NOT NULL COMMENT 'Code of the standardized item properties.
            CBX: for TX class properties: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_TX
            for HG class properties: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_HG
            LDL: P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST.MDM_ITEM_STANDARD_PROPERTY_CD',
   nfpo_item_standard_property_class_cd VARCHAR(100)     NOT NULL COMMENT 'Class of the standardized item properties: So far "TX" for textile item properties and "HG" for hard goods item properties.
            CBX: "TX" if from source column: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_TX
            "HG" if from source column: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_HG
            LDL: P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST.MDM_ITEM_STANDARD_PROPERTY_CLASS_CD',
   dwh_deleted_fg                      BOOLEAN          NOT NULL COMMENT 'If deleted_fg = 1, it means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.
            LDL: P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST.DELETED_FG',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Beginning of the validity interval of the record, oldest record of the history starts with 1900-01-01 00:00:00 (minus infinity).
            LDL: P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST.DWH_VALID_FROM',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 23:59:59 (plus infinity).
            LDL: P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST.DWH_VALID_TO',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_STANDARD_PROPERTY_ITEM_HIST PRIMARY KEY (nfpo_item_sid, nfpo_item_standard_property_class_cd, nfpo_item_standard_property_cd, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'The table contains information about standardized additional properties of NFPO items.
             CBX: LDL_ITEM_CERTIFICATION
             LDL:  P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST';

