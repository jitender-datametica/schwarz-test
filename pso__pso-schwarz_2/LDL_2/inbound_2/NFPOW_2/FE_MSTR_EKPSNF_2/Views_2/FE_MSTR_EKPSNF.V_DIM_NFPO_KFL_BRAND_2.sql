CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_KFL_BRAND_2(
	 nfpo_kfl_brand_sid
	,nfpo_kfl_brand_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS
(SELECT 
     nfpo_kfl_brand_sid
	,nfpo_kfl_brand_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_KFL_BRAND_2
);