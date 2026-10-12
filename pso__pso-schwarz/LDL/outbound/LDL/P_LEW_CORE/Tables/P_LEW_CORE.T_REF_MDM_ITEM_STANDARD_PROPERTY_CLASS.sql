/* --------------------------------------------------------------------------------
   DDL for table: t_ref_mdm_item_standard_property_class
   generated from Powerdesigner on Dienstag, 25. November 2025 15:35:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_mdm_item_standard_property_class (
mdm_item_standard_property_class_cd STRING(100) NOT NULL
OPTIONS(description='Class of the standardized item properties: So far "TX" for textile item properties and "HG" for hard goods item properties.'),
mdm_item_standard_property_class_descr STRING(250)
OPTIONS(description='Description of the class of standardized item properties.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (mdm_item_standard_property_class_cd) NOT ENFORCED
)
OPTIONS(description='Classes of item standard properties. So far "TX" for textile item properties and "HG" for hard goods item properties.             Manually filled values derived from:             CBX: LDL_ITEM_CERTIFICATION column names LDL_CERTIFICATION_PROPERTY_TX and LDL_CERTIFICATION_PROPERTY_HG             or from the CNT_CODELIST_BOOK.CODELISTNAME entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX"');