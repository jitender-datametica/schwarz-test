create or replace TABLE LDL_PRODUCTION_CLONE_GOOGLE_20260608_1030.P_LEW_CORE.T_REF_COUPON_REASON_2 (
	COUPON_REASON_NR NUMBER(38,0) NOT NULL COMMENT 'identifier of the coupon reason in SCRM',
	COUPON_REASON_DESCR VARCHAR(250) COMMENT 'description of the coupon reason in SCRM',
	EMP_COUPON_FG NUMBER(38,0) NOT NULL COMMENT 'indicates whether a coupon reason is related to employees only or not. That means that a coupon with a reason which has themp_coupon_fg = 1 can be assigned only to employees.',
	DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
	DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
	DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
	constraint PK_REF_COUPON_BOOKING_REASON primary key (COUPON_REASON_NR)
)COMMENT='this table contains the set of reasons or purposes for LidlPlus coupons'
;
