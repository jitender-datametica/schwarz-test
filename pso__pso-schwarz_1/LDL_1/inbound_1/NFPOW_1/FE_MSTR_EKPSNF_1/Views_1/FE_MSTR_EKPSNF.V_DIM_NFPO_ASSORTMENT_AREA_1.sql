CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_ASSORTMENT_AREA_1(
	 nfpo_assortment_area_id
	,nfpo_assortment_area_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS
(SELECT 
     nfpo_assortment_area_id
    ,nfpo_assortment_area_name
    ,dwh_created_tmsp
    ,dwh_updated_tmsp
    ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_ASSORTMENT_AREA_1
);

   