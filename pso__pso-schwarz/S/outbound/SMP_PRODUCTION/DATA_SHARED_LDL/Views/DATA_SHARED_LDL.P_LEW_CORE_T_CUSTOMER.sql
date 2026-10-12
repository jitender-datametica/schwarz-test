CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_customer (client_id, customer_sid, src_customerid,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 customer_sid,
 src_customerid,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_customer;