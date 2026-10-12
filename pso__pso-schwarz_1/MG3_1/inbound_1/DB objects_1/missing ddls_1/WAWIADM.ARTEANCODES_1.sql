CREATE OR REPLACE TABLE WAWIADM.ARTEANCODES_1 (
    ARTIKELNR            VARCHAR(18)    NOT NULL,
    EANCODE              VARCHAR(13)    NOT NULL,
    DATUM                TIMESTAMP_NTZ(9),
    BEDIENER             VARCHAR(8)     WITH MASKING POLICY #unknown_policy,
    EANCODEBESCHR        VARCHAR(30)    WITH MASKING POLICY #unknown_policy,
    BASED_ON_EKS         NUMBER(5,0),
    CUST_TAR_NO          VARCHAR(20),
    CUST_KEY             VARCHAR(10),
    ONLINE_DESC          VARCHAR(80)    WITH MASKING POLICY #unknown_policy,
    SCN                  NUMBER(38,0)   DEFAULT 0,
    EBT_FLAG             NUMBER(1,0),
    PCC                  VARCHAR(6),
    PLU_GTIN             NUMBER(1,0)    NOT NULL,
    NO_GTIN_CHECK        NUMBER(1,0)    NOT NULL,
    SALES_LIMIT          NUMBER(1,0),
    SELF_SCANNING_FLAG   NUMBER(1,0),
    CONSTRAINT PK_ARTEANCODES PRIMARY KEY (ARTIKELNR, EANCODE)
);