CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_EU_INCOTERM_2(
	 nfpo_eu_incoterm_cd
	,nfpo_eu_incoterm_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS
(SELECT 
     nfpo_eu_incoterm_cd
	,nfpo_eu_incoterm_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_EU_INCOTERM_2
);