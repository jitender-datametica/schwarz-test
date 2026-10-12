CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_COUNTRY(
	 nfpo_country_sid
	,nfpo_country_cd
	,nfpo_country_name
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS
(SELECT 
     nfpo_country_sid
    ,nfpo_country_cd
    ,nfpo_country_name
    ,dwh_created_tmsp
    ,dwh_updated_tmsp
    ,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_COUNTRY
);