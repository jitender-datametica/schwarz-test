CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_WORD_GROUP_1(
	 nfpo_word_grp_txt
	,nfpo_word_grp_type_cd
	,nfpo_word_grp_type_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS 
(SELECT 
	 nfpo_word_grp_txt
	,nfpo_word_grp_type_cd
	,nfpo_word_grp_type_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_WORD_GROUP_1

);