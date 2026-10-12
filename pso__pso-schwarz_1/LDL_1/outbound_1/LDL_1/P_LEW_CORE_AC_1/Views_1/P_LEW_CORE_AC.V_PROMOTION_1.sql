CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_promotion_1 (client_id, prom_sid, src_aktnr, prom_name, promotion_class_mark,
promotion_class_label, promotion_type_mark, promotion_type_label, dwh_load_id, dwh_created, dwh_updated) AS SELECT
 client_id,
 prom_sid,
 src_aktnr,
 prom_name,
 promotion_class_mark,
 promotion_class_label,
 promotion_type_mark,
 promotion_type_label,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_promotion_1;