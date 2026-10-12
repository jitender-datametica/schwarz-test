CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_PILLAR_2(
	 nfpo_pillar_sid
	,nfpo_pillar_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS
(SELECT 
     nfpo_pillar_sid
    ,nfpo_pillar_name
    ,dwh_created_tmsp
    ,dwh_updated_tmsp
    ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_PILLAR_2
);