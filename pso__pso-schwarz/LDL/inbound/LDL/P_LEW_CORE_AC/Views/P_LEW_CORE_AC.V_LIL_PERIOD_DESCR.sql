create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_LIL_PERIOD_DESCR(
	CLIENT_ID,
	PERIOD_SID,
	LANG_CD,
	PERIOD_NAME,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
SELECT
    client_id
    , period_sid
    , lang_cd
    , period_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM P_LEW_CORE.T_LIL_PERIOD_DESCR ;
