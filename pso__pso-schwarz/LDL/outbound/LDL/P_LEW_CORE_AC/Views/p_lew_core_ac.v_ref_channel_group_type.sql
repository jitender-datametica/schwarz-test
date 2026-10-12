CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_channel_group_type (channel_grp_type_cd, channel_grp_type_descr,
dwh_load_id, dwh_created, dwh_updated) AS SELECT channel_grp_type_cd,
 channel_grp_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_channel_group_type;