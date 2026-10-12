CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_ORGANIZATION(
	 nfpo_org_sid
	,nfpo_org_nr
	,nfpo_org_name
	,nfpo_org_descr
	,nfpo_map_country_name
	,lob_cd
	,lob_name
	,sales_channel_cd
	,sales_channel_name
	,display_seq
	,active_fg
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS
(SELECT 
	 nfpo_org_sid
	,nfpo_org_nr
	,nfpo_org_name
	,nfpo_org_descr
    ,nfpo_map_country_name
    ,lob_cd
	,lob_name
    ,sales_channel_cd
    ,sales_channel_name
    ,display_seq
	,active_fg
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_ORGANIZATION
);