CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_ORG_LVL_ACT_1
( org_lvl_id
, org_lvl_desc
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
     org_lvl_id,
   org_lvl_desc,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.v_ref_org_lvl_act_1
;