CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_MAIN_PILLAR(
	 nfpo_main_pillar_cd
	,nfpo_main_pillar_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS
(SELECT 
     nfpo_main_pillar_cd
    ,nfpo_main_pillar_name
    ,dwh_created_tmsp
    ,dwh_updated_tmsp
    ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_MAIN_PILLAR
);
