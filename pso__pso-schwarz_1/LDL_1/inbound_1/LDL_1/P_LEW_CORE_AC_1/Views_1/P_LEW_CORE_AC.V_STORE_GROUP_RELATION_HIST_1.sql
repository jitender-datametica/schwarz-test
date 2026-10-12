CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_STORE_GROUP_RELATION_HIST_1
(
   client_id
 , store_grp_sid
 , store_grp_sid_rel
 , store_grp_rel_type_cd
 , deleted_fg
 , dwh_valid_from
 , dwh_valid_to
 , dwh_load_id
 , dwh_created
 , dwh_updated
) 
AS
  SELECT
  client_id,
  store_grp_sid,
  store_grp_sid_rel,
  store_grp_rel_type_cd,
  deleted_fg,
  dwh_valid_from,
  dwh_valid_to,
  dwh_load_id,
  dwh_created,
  dwh_updated
FROM p_lew_core.t_store_group_relation_hist_1
;