CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_item_standard_property_class (nfpo_item_standard_property_class_cd
OPTIONS(description='''Class of the standardized item properties: So far "TX" for textile item properties and "HG" for hard goods item properties.
LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY_CLASS.MDM_ITEM_STANDARD_PROPERTY_CLASS_CD
CORE_REL: T_NFPO_ITEM_STANDARD_PROPERTY_CLASS.NFPO_ITEM_STANDARD_PROPERTY_CLASS_CD'''),
nfpo_item_standard_property_class_descr
OPTIONS(description='''Description of the class of standardized item properties.
LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY_CLASS.MDM_ITEM_STANDARD_PROPERTY_CLASS_DESCR
CORE_REL: T_NFPO_ITEM_STANDARD_PROPERTY_CLASS.NFPO_ITEM_STANDARD_PROPERTY_CLASS_DESCR'''),
dwh_created_tmsp OPTIONS(description='Timestamp of the initial insertion of the data record into the DWH.'),
dwh_updated_tmsp OPTIONS(description='Timestamp of the last change to the data record in the DWH.'), dwh_src_tmsp
OPTIONS(description='Timestamp of source extraction.'))
OPTIONS(DESCRIPTION = '''Classes of item standard properties. So far "TX" for textile item properties and "HG" for hard goods item properties.
Manually filled values derived from:
CBX: LDL_ITEM_CERTIFICATION column names LDL_CERTIFICATION_PROPERTY_TX and LDL_CERTIFICATION_PROPERTY_HG
or from the CNT_CODELIST_BOOK.CODELISTNAME entries "LDL_CERT_Properties_HG" and "LDL_CERT_Properties_TX"
LDL: P_LEW_CORE.T_REF_MDM_ITEM_STANDARD_PROPERTY_CLASS
CORE_REL: T_NFPO_ITEM_STANDARD_PROPERTY_CLASS''')
AS SELECT *
FROM nfpow_core.t_dim_nfpo_item_standard_property_class;