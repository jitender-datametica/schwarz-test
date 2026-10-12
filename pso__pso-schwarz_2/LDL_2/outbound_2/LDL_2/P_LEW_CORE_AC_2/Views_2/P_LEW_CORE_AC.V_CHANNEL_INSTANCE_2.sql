CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_channel_instance_2 (client_id, channel_inst_sid, channel_type_cd,
channel_inst_nr, channel_inst_name, channel_sid, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 channel_inst_sid,
 channel_type_cd,
 channel_inst_nr,
 channel_inst_name,
 channel_sid,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_channel_instance_2;