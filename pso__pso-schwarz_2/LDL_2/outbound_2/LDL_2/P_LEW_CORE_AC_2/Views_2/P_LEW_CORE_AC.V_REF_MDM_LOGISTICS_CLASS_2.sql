CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_logistics_class_2 (mdm_logistics_class_cd
OPTIONS(description='''Code to classify the way the items will be transported from the central warehouse of OWIM into the countries.
CBX: CNT_CODELIST.CODE (code list "LIDL_DELIVERYTYPE")'''),
mdm_logistics_class_name
OPTIONS(description='''Name to classify the way the items will be transported from the central warehouse of OWIM into the countries.
CBX: CNT_CODELIST.NAME (code list "LIDL_DELIVERYTYPE")'''),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = '''NFPO classification of the way the items will be transported from the central warehouse of OWIM into the countries.
CBX: CNT_CODELIST_2 (code list "LIDL_DELIVERYTYPE")''')
AS SELECT mdm_logistics_class_cd,
 mdm_logistics_class_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_logistics_class_2;