CREATE TABLE META.T_LOOKUP_CUST_ORDER_NR_R3_TO_S4 (
	LEAD_SRC_NAME VARCHAR(5) COMMENT 'Source system from which the record was fetched (e.g. SEP)',
    LEAD_SRC_LOG_SYS_CD VARCHAR(5) COMMENT 'SAP MANDT code associated with the source system',
    SRC_CUST_ORDER_NR VARCHAR(20) COMMENT 'Initial cust_order_nr (SAP VBELN code) from the legacy system (i.e. SAP R3)',
	TGT_CUST_ORDER_NR VARCHAR(20) COMMENT 'New cust_order_nr in the current system (i.e. SAP S4 Hana)',
    CHECK_KEY VARCHAR(40) COMMENT 'Concatenated primary key (unique combination behind the cust_order_sid), for debugging and R3-to-S4 mapping performance',
    SRC_FILE_TMSP TIMESTAMP_LTZ(9) COMMENT 'The point in time when this record was extracted from the source',
CONSTRAINT T_LEGACY_CUST_ORDER_NR_R3_TO_S4 PRIMARY KEY (SRC_CUST_ORDER_NR, LEAD_SRC_NAME, LEAD_SRC_LOG_SYS_CD)
);