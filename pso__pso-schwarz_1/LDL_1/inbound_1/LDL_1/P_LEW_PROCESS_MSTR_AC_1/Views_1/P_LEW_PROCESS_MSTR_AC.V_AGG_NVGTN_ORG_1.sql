CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_AGG_NVGTN_ORG_1
(
  int_id
, client_ctry_id
, client_id
, curr_client_id
, aspect_id
, wh_id
, move_to_store_id
, org_lvl_id
, org_ele_link
, org_ele_desc
, org_brdcrum
, load_id
, dwh_inserted
, dwh_updated
)
AS
   SELECT
     int_id,
   client_ctry_id,
   client_id,
   curr_client_id,
   aspect_id,
   wh_id,
   move_to_store_id,
   org_lvl_id,
   org_ele_link,
   org_ele_desc,
   org_brdcrum,
   load_id,
   dwh_inserted,
   dwh_updated
  FROM p_lew_process_mstr.t_agg_nvgtn_org_1
;