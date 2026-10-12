create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_MDM_RANGE_SELECTION_2(
	CLIENT_ID,
	MDM_RANGE_SEL_SID,
	SRC_PROG_DOC_REF,
	RANGE_PLAN_CD,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       client_id,
   mdm_range_sel_sid,
   src_prog_doc_ref,
   range_plan_cd,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_mdm_range_selection_2
;
