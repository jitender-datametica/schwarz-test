CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_customer_need_type_2 (mdm_cust_need_type_cd
OPTIONS(description='''Code to classify the assortment by general customer needs.
CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")'''),
mdm_cust_need_type_name
OPTIONS(description='''Name of the general customer need.
CBX: CNT_CODELIST.NAME (code list "LIDL_FOCUS_CATEGORY")'''),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = '''Classification of the assortment by general customer needs.
CBX: CNT_CODELIST.CODE (code list "LIDL_FOCUS_CATEGORY")''')
AS SELECT mdm_cust_need_type_cd,
 mdm_cust_need_type_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_customer_need_type_2;