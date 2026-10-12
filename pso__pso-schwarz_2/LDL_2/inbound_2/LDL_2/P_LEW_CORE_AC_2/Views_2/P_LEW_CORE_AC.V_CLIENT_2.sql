create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_CLIENT_2(
	CLIENT_ID,
	SRC_CLIENT_ID,
	SRC_COUNTRY_LIDL_CD,
	SRC_COUNTRY_CBX_CD,
	CLIENT_NAME,
	COUNTRY_SID,
	COUNTRY_CD,
	CURR_SID,
	CURR_CD,
	CLIENT_ONLINE_FG,
	LOB_CD,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
SELECT
client_id
,src_client_id
,src_country_lidl_cd
,src_country_cbx_cd
,client_name
,country_sid
,country_cd
,curr_sid
,curr_cd
,client_online_fg
,lob_cd
,dwh_load_id
,dwh_created
,dwh_updated
FROM p_lew_core.t_client_2
;
