CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_channel_to_channel_group_hist (client_id, channel_sid, channel_grp_sid,
channel_grp_type_cd, comm_channel_grp_type_cd, display_order_seq, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id
, dwh_created, dwh_updated) AS SELECT client_id,
 channel_sid,
 channel_grp_sid,
 channel_grp_type_cd,
 comm_channel_grp_type_cd,
 display_order_seq,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_channel_to_channel_group_hist;