CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_customer_need_subtype_2 (mdm_cust_need_subtype_cd
OPTIONS(description='''Code to classify the assortment by detailed customer needs.
CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")'''),
mdm_cust_need_type_cd
OPTIONS(description='''Current code to classify the detailed customer need by general customer needs.
CBX: CMT_CODELIST_BOOK.cust_codelist1 (code list "LIDL_CATEGORY_NEEDS")'''),
mdm_cust_need_subtype_name
OPTIONS(description='''Name of the detailed customer need.
CBX: CNT_CODELIST.NAME (code list "LIDL_CATEGORY_NEEDS")'''),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = '''Classification of the assortment by detailed customer needs. The detailed customer needs are grouped into general customer needs.
CBX: CNT_CODELIST.CODE (code list "LIDL_CATEGORY_NEEDS")''')
AS SELECT mdm_cust_need_subtype_cd,
 mdm_cust_need_type_cd,
 mdm_cust_need_subtype_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_customer_need_subtype_2;