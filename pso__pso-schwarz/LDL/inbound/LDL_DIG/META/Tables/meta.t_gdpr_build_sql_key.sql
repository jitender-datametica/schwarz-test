CREATE TABLE META.T_GDPR_BUILD_SQL_KEY (
        BUILD_SQL_KEYS_ID   INT IDENTITY(1,1) NOT NULL,
        KEY_NAME            VARCHAR2(250),
        CUST_KEY            VARCHAR2(250),        
        KUNNR               VARCHAR(250),
        TYPE_CD             VARCHAR2(250),
        CUST_TYPE           VARCHAR(250),
        PARENT_KEY_NAME     VARCHAR(250),
	PARENT_KEY_VALUE    VARCHAR(250)
);