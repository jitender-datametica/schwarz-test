CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_BRAND_TYPE(
	 nfpo_brand_type_cd
	,nfpo_brand_type_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS
(SELECT 
     nfpo_brand_type_cd
    ,nfpo_brand_type_name
    ,dwh_created_tmsp
    ,dwh_updated_tmsp
    ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_BRAND_TYPE
);
