create or replace view LDL_PRODUCTION.P_LEW_PROCESS_MSTR_AC.V_LIL_REGION_2(
	CLIENT_ID,
	REGION_SID,
	REGION_ID,
	SRC_REGION_CD,
	REGION_NAME_EN,
	REGION_NAME_DE,
	REGION_SHORT_DESC,
	REGION_LONG_DESC,
	REGION_SRT_CD,
	QR_SRT_CD,
	REGION_LVL,
	SD_CHLD_BELOW_12,
	SD_CHLD_OVER_12,
	ACTIVE_FG,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
SELECT
      client_id
    , region_sid
    , region_id
    , src_region_cd
    , region_name_en
    , region_name_de
    , region_short_desc
    , region_long_desc
    , region_srt_cd
    , qr_srt_cd
    , region_lvl
    , sd_chld_below_12
    , sd_chld_over_12
    , active_fg
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM p_lew_process_mstr.t_lil_region_2
;
