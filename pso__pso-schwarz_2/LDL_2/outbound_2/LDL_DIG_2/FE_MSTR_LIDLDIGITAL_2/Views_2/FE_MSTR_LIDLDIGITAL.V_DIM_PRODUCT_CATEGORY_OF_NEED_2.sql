-- DWH_UPDATED_TMSP
 -- SRC_FILE_TMSP
 -- DWH_CREATED_TMSP

CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_category_of_need_2 (category_of_need_cd,
category_of_need_name, world_of_need_cd, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_file_name, src_file_tmsp) AS SELECT
 category_of_need_cd,
 category_of_need_name,
 world_of_need_cd,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_src_file_name,
 src_file_tmsp
FROM ldl_dig_lec_share.v_dim_product_category_of_need_2
UNION ALL
SELECT '-1' -- CATEGORY_OF_NEED_CD
,
 '' -- CATEGORY_OF_NEED_NAME
,
 '-1' -- WORLD_OF_NEED_CD
,
 '1900-01-01 00:00:00',
 '1900-01-01 00:00:00',
 '' -- DWH_SRC_FILE_NAME
,
 '1900-01-01 00:00:00';