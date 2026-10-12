CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_coupon_relation_type_1 (coupon_relation_type_cd, coupon_relation_type_descr
, dwh_load_id, dwh_created, dwh_updated) AS SELECT coupon_relation_type_cd,
 coupon_relation_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_coupon_relation_type_1;