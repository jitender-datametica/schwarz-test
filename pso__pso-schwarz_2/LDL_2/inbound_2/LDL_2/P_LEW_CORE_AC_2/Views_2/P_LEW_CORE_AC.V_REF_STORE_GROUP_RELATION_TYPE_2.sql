CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_REF_STORE_GROUP_RELATION_TYPE_2
(
   store_grp_rel_type_cd
 , store_grp_rel_type_descr
 , dwh_load_id
 , dwh_created
 , dwh_updated
) 
AS
  SELECT
  store_grp_rel_type_cd,
  store_grp_rel_type_descr,
  dwh_load_id,
  dwh_created,
  dwh_updated
FROM p_lew_core.t_ref_store_group_relation_type_2
;