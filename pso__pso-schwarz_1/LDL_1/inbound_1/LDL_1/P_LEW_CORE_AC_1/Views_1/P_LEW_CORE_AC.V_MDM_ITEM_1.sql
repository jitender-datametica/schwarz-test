create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_MDM_ITEM_1(
	CLIENT_ID,
	MDM_ITEM_SID,
	SRC_ITEM_DOC_REF,
	MDM_ITEM_NAME,
	ITEM_IAN,
	RANGE_PLAN_CD,
	ITEM_SELECTION_NR,
	STEP_ITEM_NR,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
   client_id
   ,mdm_item_sid
   ,src_item_doc_ref
   ,mdm_item_name
   ,item_ian
   ,range_plan_cd
   ,item_selection_nr
   ,step_item_nr
   ,dwh_load_id
   ,dwh_created
   ,dwh_updated
  FROM p_lew_core.t_mdm_item_1 ;
