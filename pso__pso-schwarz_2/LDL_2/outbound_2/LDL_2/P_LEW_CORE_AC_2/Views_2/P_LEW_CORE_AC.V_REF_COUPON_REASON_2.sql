CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_coupon_reason_2 (coupon_reason_nr
OPTIONS(description='identifier of the coupon reason in SCRM'), coupon_reason_descr
OPTIONS(description='description of the coupon reason in SCRM'), emp_coupon_fg
OPTIONS(description='indicates whether a coupon reason is related to employees only or not. That means that a coupon with a reason which has themp_coupon_fg = 1 can be assigned only to employees.'),
dwh_load_id OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'), dwh_updated
OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH')) AS SELECT coupon_reason_nr,
 coupon_reason_descr,
 emp_coupon_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_coupon_reason_2;