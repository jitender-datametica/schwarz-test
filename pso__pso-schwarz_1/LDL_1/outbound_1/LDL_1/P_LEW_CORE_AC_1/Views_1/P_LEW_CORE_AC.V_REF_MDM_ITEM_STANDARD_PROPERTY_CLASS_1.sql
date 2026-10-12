CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_item_standard_property_class_1 (mdm_item_standard_property_class_cd
OPTIONS(description='Class of the standardized item_1 properties: So far "TX" for textile item_1 properties and "HG" for hard goods item_1 properties.'),
mdm_item_standard_property_class_descr OPTIONS(description='Description of the class of standardized item_1 properties.'),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = `CLASSES OF ITEM_1 STANDARD PROPERTIES. SO FAR "TX" FOR TEXTILE ITEM_1 PROPERTIES AND "HG" FOR HARD GOODS ITEM_1 PROPERTIES.MANUALLY FILLED VALUES DERIVED FROM:CBX: LDL_ITEM_CERTIFICATION COLUMN NAMES LDL_CERTIFICATION_PROPERTY_TX AND LDL_CERTIFICATION_PROPERTY_HGOR FROM THE CNT_CODELIST_BOOK.CODELISTNAME ENTRIES "LDL_CERT_PROPERTIES_HG" AND "LDL_CERT_PROPERTIES_TX"`)
AS SELECT mdm_item_standard_property_class_cd,
 mdm_item_standard_property_class_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_item_standard_property_class_1;