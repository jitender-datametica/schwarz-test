CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_pos_land_discount_2 (client_id, discount_id, src_discount_nr, src_posart,
discount_pct, discount_descr, first_appearance_dt, lidlplus_coupon_pattern_fg, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 discount_sid AS discount_id,
 src_discount_nr,
 src_posart,
 src_discount_pct AS discount_pct,
 discount_descr,
 first_appearance_dt,
 lidlplus_coupon_pattern_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core_ac.v_pos_discount_2
WHERE ROUND(SAFE_CAST(src_discount_nr AS BIGNUMERIC), 0) IN (0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
 AND src_discount_pct IS NOT NULL;
