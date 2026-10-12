CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_coupon (client_id, coupon_sid, src_country, src_id, coupon_type_cd, coupon_nr
, coupon_name, loyalty_prog_cd, geo_area_sid, geo_area_cd, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 coupon_sid,
 src_country,
 src_id,
 coupon_type_cd,
 coupon_nr,
 coupon_name,
 loyalty_prog_cd,
 geo_area_sid,
 geo_area_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_coupon;