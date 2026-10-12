CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_VAT_VALUES_STORE_HQ_L_0
(
  COUNTRY_ISO_CD    VARCHAR(2) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ          NUMBER(38)                    NOT NULL,
  ORIG_STORE_NR     NUMBER(38)                    NOT NULL,
  VAT_ID            NUMBER(38)                    NOT NULL,
  STORE_VAT_ID      NUMBER(38)                    NOT NULL,
  COUNTRY_CD        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  DAT_MODIFICATION  DATE                          NULL,
  FILE_NAME         VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  TIMESTAMP_FN      TIMESTAMP_NTZ(0)              NOT NULL,
  DAT_DAYEND        DATE                          NOT NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL,
  DC_SERVER_ID      NUMBER(38)                    NOT NULL,
  BIC_ZMLILA        VARCHAR(20)                   NULL,
  EXTRACTION_TS     TIMESTAMP_NTZ(6)              NULL,
  RECORD_ID         NUMBER(10,0)                  NULL,
  SOURCE_SYSTEM     VARCHAR(20) COLLATE 'en-ci'   NULL
);