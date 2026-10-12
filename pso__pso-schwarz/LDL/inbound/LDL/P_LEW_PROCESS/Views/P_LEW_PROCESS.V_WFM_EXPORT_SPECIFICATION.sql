create or replace view LDL_PRODUCTION.P_LEW_PROCESS.V_WFM_EXPORT_SPECIFICATION(
	CLIENT_ID,
	COUNTRY_LIDL_CD,
	EXPORT_SPECIFICATION,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       v.client_id,
   v.country_lidl_cd,
   v.export_specification,
   v.dwh_created,
   v.dwh_updated
  FROM p_lew_process.t_wfm_export_specification AS v
;
