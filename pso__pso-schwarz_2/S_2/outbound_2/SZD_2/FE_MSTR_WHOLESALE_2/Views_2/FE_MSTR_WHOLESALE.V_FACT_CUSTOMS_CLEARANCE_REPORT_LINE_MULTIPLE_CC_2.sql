CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_fact_customs_clearance_report_line_multiple_cc_2 (clearance_dt,
item_position, cy_month, consignor_party_sid, importer_party_sid, importer_number, declarant_party_sid, declarant_number
, declarant_name, declarant_authorized_fg, origin_country_location_sid, origin_iso_country_cd, customs_tariff_number_cd
, customs_product_number, goods_descr, duty_paid_val, curr_cd, multiple_cc_fg, cc2_fg, cc3_fg, cc4_fg, over_4_cc_fg) AS
SELECT DISTINCT clearance_dt,
 item_position,
 cy_month,
 consignor_party_sid,
 importer_party_sid,
 importer_number,
 declarant_party_sid,
 declarant_number,
 declarant_name,
 declarant_authorized_fg,
 origin_country_location_sid,
 origin_iso_country_cd,
 customs_tariff_number_cd,
 customs_product_number,
 goods_descr,
 duty_paid_val,
 curr_cd,
  CASE
  WHEN (COUNT(customs_tariff_number_cd) OVER (PARTITION BY customs_product_number RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING)) > 1
  THEN 1
  ELSE 0
  END AS multiple_cc_fg,
  CASE
  WHEN (COUNT(customs_tariff_number_cd) OVER (PARTITION BY customs_product_number RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING)) = 2
  THEN 1
  ELSE 0
  END AS cc2_fg,
  CASE
  WHEN (COUNT(customs_tariff_number_cd) OVER (PARTITION BY customs_product_number RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING)) = 3
  THEN 1
  ELSE 0
  END AS cc3_fg,
  CASE
  WHEN (COUNT(customs_tariff_number_cd) OVER (PARTITION BY customs_product_number RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING)) = 4
  THEN 1
  ELSE 0
  END AS cc4_fg,
  CASE
  WHEN (COUNT(customs_tariff_number_cd) OVER (PARTITION BY customs_product_number RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING)) > 4
  THEN 1
  ELSE 0
  END AS over_4_cc_fg
FROM szd_core.t_fact_customs_clearance_report_line_2;