create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_WAWI_INDICATOR_MONTH_1(
	CLIENT_ID,
	ORG_TYPE_ID,
	ORG_UNIT_NR,
	INDICATOR_ID,
	INDICATOR_TYPE_ID,
	CY,
	MONTH_ID,
	VAL_INDICATOR,
	TIMESTAMP_FN,
	DAT_DAYEND,
	LOAD_ID
) as
   SELECT
       client_id,
   org_type_id,
   org_unit_nr,
   indicator_id,
   indicator_type_id,
   cy,
   month_id,
   val_indicator,
   timestamp_fn,
   dat_dayend,
   load_id
   FROM p_lew_core.t_wawi_indicator_month_1;
