CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_fact_customs_clearance_report_line_per_day_product_origin_country (clearance_dt
, authority_country_location_sid, origin_country_location_sid, consignor_party_sid, customs_product_sid,
customs_preference_cd, agreement_sid, customs_declaration_type_cd, declaration_cnt, duty_paid_val, curr_cd) AS SELECT
 clearance_dt,
 authority_country_location_sid,
 origin_country_location_sid,
 consignor_party_sid,
 customs_product_sid,
 customs_preference_cd,
 agreement_sid,
 customs_declaration_type_cd,
 declaration_cnt,
 duty_paid_val,
 curr_cd
FROM szd_core.t_fact_customs_clearance_report_line_per_day_product_origin_country;