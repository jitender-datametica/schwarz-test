CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_customer_2 (client_id, customer_sid, src_customerid, dwh_load_id, dwh_created,
dwh_updated) AS SELECT client_id,
 customer_sid,
 src_customerid,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_customer_2;