CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_COMPETITOR_1(
	 nfpo_competitor_sid
	,nfpo_competitor_cd
	,nfpo_competitor_name
	,nfpo_competitor_abbr_name
	,is_competitor_1_fg
	,is_competitor_2_fg
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS
(SELECT 
	 nfpo_competitor_sid
	,nfpo_competitor_cd
	,nfpo_competitor_name
	,nfpo_competitor_abbr_name
	,is_competitor_1_fg
	,is_competitor_2_fg
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_COMPETITOR_1
);