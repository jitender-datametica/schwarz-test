/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_item_standard_property_item_hist_2
   generated from Powerdesigner on Freitag, 12. Dezember 2025 14:01:01
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_standard_property_item_hist_2 (
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Foreign Key NFPO ITEM_2 INSTANCE.            CBX: LDL_ITEM_CERTIFICATION.ITEM_ID            LDL: P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST.MDM_ITEM_SID'),
nfpo_item_standard_property_cd STRING(100) NOT NULL
OPTIONS(description='Code of the standardized item_2 properties.            CBX: for TX class properties: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_TX            for HG class properties: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_HG            LDL: P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST.MDM_ITEM_STANDARD_PROPERTY_CD'),
nfpo_item_standard_property_class_cd STRING(100) NOT NULL
OPTIONS(description='Class of the standardized item_2 properties: So far "TX" for textile item_2 properties and "HG" for hard goods item_2 properties.            CBX: "TX" if from source column: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_TX            "HG" if from source column: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_HG            LDL: P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST.MDM_ITEM_STANDARD_PROPERTY_CLASS_CD'),
dwh_deleted_fg BOOL NOT NULL
OPTIONS(description='If deleted_fg = 1, it means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.            LDL: P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST.DELETED_FG'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Beginning of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 00:00:00 (minus infinity).            LDL: P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST.DWH_VALID_FROM'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='End of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 23:59:59 (plus infinity).            LDL: P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST.DWH_VALID_TO'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Timestamp of the last change to the data record in the DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_sid, nfpo_item_standard_property_class_cd, nfpo_item_standard_property_cd, dwh_valid_from_tmsp)
NOT ENFORCED
)
OPTIONS(description='The table contains information about standardized additional properties of NFPO items.             CBX: LDL_ITEM_CERTIFICATION             LDL:  P_LEW_CORE.T_MDM_ITEM_STANDARD_PROPERTY_ITEM_HIST_2');