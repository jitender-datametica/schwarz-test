CREATE OR REPLACE TABLE ldl_p_lew_core.t_ref_coupon_reason (
coupon_reason_nr INTEGER NOT NULL OPTIONS(description='identifier of the coupon reason in SCRM'),
coupon_reason_descr STRING(250) OPTIONS(description='description of the coupon reason in SCRM'),
emp_coupon_fg INTEGER NOT NULL
OPTIONS(description='indicates whether a coupon reason is related to employees only or not. That means that a coupon with a reason which has themp_coupon_fg = 1 can be assigned only to employees.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat'),
dwh_created DATETIME NOT NULL OPTIONS(description='Zeitstempel der Ersteinfuegung des Datensatzes ins DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'),
PRIMARY KEY (coupon_reason_nr) NOT ENFORCED
) OPTIONS(description='this table contains the set of reasons or purposes for LidlPlus coupons');