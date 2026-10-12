-- DWH_CREATED_TMSP
 -- SRC_FILE_TMSP
 -- DWH_UPDATED_TMSP

CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_subcategory_of_need_1 (subcategory_of_need_cd,
subcategory_of_need_name, category_of_need_cd, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_file_name, src_file_tmsp) AS
SELECT subcategory_of_need_cd,
 subcategory_of_need_name,
 category_of_need_cd,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_src_file_name,
 src_file_tmsp
FROM ldl_dig_lec_share.v_dim_product_subcategory_of_need_1
UNION ALL
SELECT '-1' -- SUBCATEGORY_OF_NEED_CD
,
 '' -- SUBCATEGORY_OF_NEED_NAME
,
 '-1' -- CATEGORY_OF_NEED_CD
,
 '1900-01-01 00:00:00',
 '1900-01-01 00:00:00',
 '' -- DWH_SRC_FILE_NAME
,
 '1900-01-01 00:00:00';