CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_ITEM_QUALITY_CLASS_2(
	 nfpo_item_quality_class_cd
	,nfpo_item_quality_class_descr
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS
(SELECT 
	 nfpo_item_quality_class_cd
	,nfpo_item_quality_class_descr
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_ITEM_QUALITY_CLASS_2
);