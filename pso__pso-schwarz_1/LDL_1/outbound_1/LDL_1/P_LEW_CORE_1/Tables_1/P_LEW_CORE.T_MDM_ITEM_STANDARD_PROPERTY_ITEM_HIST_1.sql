/* --------------------------------------------------------------------------------
   DDL for table: t_mdm_item_standard_property_item_hist_1
   generated from Powerdesigner on Dienstag, 25. November 2025 15:35:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_item_standard_property_item_hist_1 (
mdm_item_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='''foreign key NFPO item_1 instance
            CBX: LDL_ITEM_CERTIFICATION.ITEM_ID'''),
mdm_item_standard_property_cd STRING(100) NOT NULL
OPTIONS(description='''Code of the standardized item_1 properties.
            CBX: for TX class properties: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_TX
            for HG class properties: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_HG'''),
mdm_item_standard_property_class_cd STRING(100) NOT NULL
OPTIONS(description='''Class of the standardized item_1 properties: So far "TX" for textile item_1 properties and "HG" for hard goods item_1 properties.
            CBX: "TX" if from source column: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_TX
            "HG" if from source column: LDL_ITEM_CERTIFICATION.LDL_CERTIFICATION_PROPERTY_HG'''),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Deleted_fg = 1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.'),
dwh_valid_from DATE NOT NULL
OPTIONS(description='Begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity).'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='End of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity).'),
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Technical column required by the used ETL framework. Static 7 for all rows.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_sid, mdm_item_standard_property_class_cd, mdm_item_standard_property_cd, dwh_valid_from)
NOT ENFORCED
)
OPTIONS(description='''The table contains information about standardized additional properties of NFPO items.
             CBX: LDL_ITEM_CERTIFICATION''');