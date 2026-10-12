create or replace view LDL_PRODUCTION.P_LEW_CORE_AC.V_MDM_ITEM_SET_1(
	CLIENT_ID,
	MDM_ITEM_SET_SID,
	SRC_ITEM_DOC_REF,
	SRC_STYLE_UNIQIDS_CD,
	SET_MULTIPACK_FG,
	MDM_ITEM_SID,
	DWH_LOAD_ID,
	DWH_CREATED,
	DWH_UPDATED
) as
   SELECT
       client_id,
   mdm_item_set_sid,
   src_item_doc_ref,
   src_style_uniqids_cd,
   set_multipack_fg,
   mdm_item_sid,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_core.t_mdm_item_set_1 ;
