CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_channel_group (client_id, channel_grp_sid, src_adv_medium_grp_id,
channel_grp_type_cd, comm_channel_grp_type_cd, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 channel_grp_sid,
 src_adv_medium_grp_id,
 channel_grp_type_cd,
 comm_channel_grp_type_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_channel_group;