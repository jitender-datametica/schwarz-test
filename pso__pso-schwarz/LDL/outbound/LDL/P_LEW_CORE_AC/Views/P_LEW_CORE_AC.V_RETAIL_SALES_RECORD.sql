CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_retail_sales_record (client_id, retail_sales_record_id, curr_sid, curr_cd,
invoice_class_cd, invoice_type_cd, dwh_cal_dt, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 retail_sales_record_id,
 curr_sid,
 curr_cd,
 invoice_class_cd,
 invoice_type_cd,
 dwh_cal_dt,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_retail_sales_record;