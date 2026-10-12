CREATE TRANSIENT TABLE P_LEW_LOAD.T_REF_WAWI_STORE_VAT_VALUES_999
(
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  ST_LOC_SID        NUMBER(38)                    NOT NULL,
  VAT_ID            NUMBER(38)                    NOT NULL,
  COUNTRY_CD        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  DAT_REC_START     DATE                          NOT NULL,
  STORE_VAT_ID      NUMBER(38)                    NULL,
  PCT_VAT           NUMBER(4,2)                   NOT NULL,
  STORE_PCT_VAT     NUMBER(4,2)                   NULL,
  DAT_REC_END       DATE                          NOT NULL,
  DAT_MODIFICATION  DATE                          NOT NULL,
  DAT_DAYEND        DATE                          NOT NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL
);