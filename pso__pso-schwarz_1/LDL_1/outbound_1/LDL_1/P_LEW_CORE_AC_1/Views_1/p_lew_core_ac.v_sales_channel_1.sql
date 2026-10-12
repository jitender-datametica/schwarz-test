CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_sales_channel_1 (client_id, sales_channel_sid, sales_channel_cd,
sales_channel_name, sales_channel_descr, dwh_updated, dwh_load_id, dwh_created) AS SELECT client_id,
 sales_channel_sid,
 sales_channel_cd,
 sales_channel_name,
 sales_channel_descr,
 dwh_updated,
 dwh_load_id,
 dwh_created
FROM ldl_p_lew_core.t_sales_channel_1;