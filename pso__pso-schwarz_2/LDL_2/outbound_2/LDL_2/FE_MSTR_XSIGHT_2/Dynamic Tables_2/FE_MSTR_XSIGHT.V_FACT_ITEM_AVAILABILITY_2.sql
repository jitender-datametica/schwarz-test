
CREATE TABLE IF NOT EXISTS ldl_fe_mstr_xsight.v_fact_item_availability_2
 AS
/* JOIN LDL.FE_MSTR_XSIGHT.V_DIM_BENCHMARK_CHANNEL_2 A16 ON (A11.COUNTRY_CD = A16.COUNTRY_CD 
 	AND A11.CHANNEL_SID = A16.CHANNEL_SID 
 	AND A11.DATA_SRC_SEGMENT_NAME = A16.DATA_SRC_SEGMENT_NAME) */
SELECT DISTINCT COALESCE(A12.brand_name, 'N/A') AS brand_name,
 COALESCE(A12.hierarchy_lvl_1, 'N/A') AS hierarchy_lvl_1,
 COALESCE(A12.hierarchy_lvl_2, 'N/A') AS hierarchy_lvl_2,
 COALESCE(A12.hierarchy_lvl_3, 'N/A') AS hierarchy_lvl_3,
 COALESCE(A12.hierarchy_lvl_4, 'N/A') AS hierarchy_lvl_4,
 COALESCE(A12.hierarchy_lvl_5, 'N/A') AS hierarchy_lvl_5,
 COALESCE(A12.manufacturer_name, 'N/A') AS manufacturer_name,
 COALESCE(A12.item_fam_grp_cd, '-1') AS item_fam_grp_cd,
 COALESCE(A12.item_grp_int_cd, '-1') AS item_grp_int_cd,
 COALESCE(A12.sub_brand_name, 'N/A') AS sub_brand_name,
 COALESCE(A12.sub_item_grp_cd, '-1') AS sub_item_grp_cd,
 A13.period_sid,
 A13.period_name,
 A13.period_type_cd,
 A12.data_src_segment_name,
 A14.data_src_segment_descr,
 A12.country_cd,
 A15.country_name
FROM ldl_fe_mstr_xsight.t_fact_research_metric_2 AS A11
 INNER JOIN ldl_fe_mstr_xsight.v_dim_product_2 AS A12 ON A11.prod_sid = A12.prod_sid
 INNER JOIN ldl_fe_mstr_xsight.v_dim_period_2 AS A13 ON A11.cy_business_period_sid = A13.period_sid
 INNER JOIN ldl_fe_mstr_xsight.v_dim_data_source_segment_2 AS A14 ON A12.data_src_segment_name = A14.data_src_segment_name
      AND A12.country_cd = A14.country_cd AND A12.data_src_name = A14.data_src_name AND A12.data_provider_name = A14.data_provider_name
   
 INNER JOIN ldl_fe_mstr_xsight.v_dim_country_2 AS A15 ON A12.country_cd = A15.country_cd
WHERE A12.hierarchy_lvl_1 IS NOT NULL
 AND A12.hierarchy_level_0 = 'ITEM_2 CODE';


