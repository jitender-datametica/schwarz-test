CREATE OR REPLACE VIEW ldl_p_lew_mart_cm_ac.v_lil_compare_delv_deadline_1 (client_id, per_id, interface_name, per_end_date
, status_1, delivery_content, delivery_content_smart_desc, delivery_content_smart_desc_en, min_delivery_date,
max_delivery_date, delivery_count) AS SELECT *
FROM ldl_p_lew_mart_cm.v_lil_compare_delv_deadline_1;