CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM_AC.V_PIT_VERSION_INFO
AS
SELECT
version_dt
,dwh_valid_from
,dwh_valid_to
,major_number
,minor_number
,build_number
,revision_number
,version_info_descr
,version_info_descr_long
,version_number_descr
FROM p_lew_mart_pit_onprem.v_pit_version_info;