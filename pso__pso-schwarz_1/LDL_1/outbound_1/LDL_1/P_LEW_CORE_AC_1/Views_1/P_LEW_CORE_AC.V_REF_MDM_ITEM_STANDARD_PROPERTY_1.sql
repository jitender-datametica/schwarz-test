CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_item_standard_property_1 (mdm_item_standard_property_cd
OPTIONS(description='''Code of the standardized item_1 property.
CBX: CNT_CODELIST.CODE (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)'''),
mdm_item_standard_property_class_cd
OPTIONS(description='''Class of the standardized item_1 properties: So far "TX" for textile item_1 properties and "HG" for hard goods item_1 properties
CBX: CNT_CODELIST_BOOK.CODELISTNAME (code list "LDL_CERT_Properties_TX" and "LDL_CERT_Properties_HG"), CNT_CODELIST.CODE (code list "CERT_TX*" and "CERT_HG*")'''),
mdm_item_standard_property_txt
OPTIONS(description='''Text containing names, abbreviations and descriptions of the standardized item_1 property.
CBX: CNT_CODELIST.NAME (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)'''),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = '''Item_1 standard properties, grouped by class.
CBX: CNT_CODELIST_BOOK_1 (for the code list entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX" in CNT_CODELIST_BOOK.CODELISTNAME)''')
AS SELECT mdm_item_standard_property_cd,
 mdm_item_standard_property_class_cd,
 mdm_item_standard_property_txt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_item_standard_property_1;