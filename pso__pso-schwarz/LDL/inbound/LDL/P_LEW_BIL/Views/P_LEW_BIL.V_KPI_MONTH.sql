create or replace view LDL_PRODUCTION.P_LEW_BIL.V_KPI_MONTH(
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
   /* This view delivers all monthly-based KPIs (dt. Kennzahlen).	
   *  We call it """"UNIFY VIEW"""", because =SOME specific KPIs= are extracted from the	
   *  new denormalized core tables (see sub-select of second select), while the	
   *  rest of all other KPIs are fetched from the old normalized table	
   *  """"LEW_CORE.t_wawi_indicator_month"""".	
   *  The new denoramlized tables contains KPIs imported automatically from	
   *  SAP HANA (DB-VIEW) via new ETLs. The objective is to incrementally migrate	
   *  all KPIs to the new denormalized model, so that only second select remains.	
   *  The really long term objective is however to change all BIL views & marts,	
   *  so that they consume directly the new denormalized tables	
   *  (this view will then become obsolete).	
   **/	
	
   -- ### KPIs from the old normalized table: LEW_CORE.t_wawi_indicator_month	
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
  FROM p_lew_core_ac.v_wawi_indicator_month	;
