CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_mdm_sales_packaging_type (mdm_sales_packaging_type_cd
OPTIONS(description='''Code of the sales packaging types.
CBX: CNT_CODELIST.CODE (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")'''),
mdm_sales_packaging_type_name
OPTIONS(description='''Name of the sales packaging types.
CBX: CNT_CODELIST.NAME (code lists "LIDL_RETAILPACK" and "LIDL_RETAILPACK_KL")'''),
dwh_load_id
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created OPTIONS(description='Creation timestamp of the record in the DWH.'), dwh_updated
OPTIONS(description='Timestamp of the last update of the record in the DWH.'))
OPTIONS(DESCRIPTION = '''NFPO list of sales packaging types.
CBX: CNT_CODELIST (code list "LDL_RETAIL_PACKAGING" and "LIDL_RETAILPACK_KL")''')
AS SELECT mdm_sales_packaging_type_cd,
 mdm_sales_packaging_type_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_sales_packaging_type;