create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_LIL_RETAILER_PERIOD_2(
	CLIENT_ID,
	RETAILER_SID,
	PERIOD_SID,
	RETAILER_SID_PARENT,
	INTERFACE_NAME,
	DELETED_FG,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
SELECT
    client_id
    , retailer_sid
    , period_sid
    , retailer_sid_parent
    , interface_name
    , deleted_fg
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM P_LEW_CORE.t_lil_retailer_period_2 ;
