create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_REF_BUILDING_CLOSING_REASON_1(
	CLIENT_ID,
	CLOSING_REASON_ID,
	CLOSING_REASON_DESCR,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       client_id,
   closing_reason_id,
   closing_reason_descr,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_ref_building_closing_reason_1
;
