CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_advertisement_channel (client_id, adv_channel_sid, adv_channel_cd,
adv_channel_name, adv_channel_short_name, adv_channel_descr, int_std_fg, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 adv_channel_sid,
 adv_channel_cd,
 adv_channel_name,
 adv_channel_short_name,
 adv_channel_descr,
 int_std_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_advertisement_channel;