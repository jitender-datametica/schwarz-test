create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR_AC.V_LIL_REGION_RETAILER_1(
	CLIENT_ID,
	REGION_SID,
	RETAILER_SID,
	RTL_ID,
	REGION_RTL_DESC_DE,
	REGION_RTL_DESC_EN,
	RTL_LVL,
	ACTIVE_FG,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
SELECT
    client_id
    , region_sid
    , retailer_sid
    , rtl_id
    , region_rtl_desc_de
    , region_rtl_desc_en
    , rtl_lvl
    , active_fg
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM P_LEW_PROCESS_MSTR.T_LIL_REGION_RETAILER_1 ;
