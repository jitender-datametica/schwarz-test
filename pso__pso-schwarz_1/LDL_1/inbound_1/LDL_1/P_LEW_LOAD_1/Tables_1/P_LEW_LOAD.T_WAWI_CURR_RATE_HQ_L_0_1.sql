CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_CURR_RATE_HQ_L_0_1
(
  COUNTRY_ISO_CD          VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ                VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  CURRENCY_NR             NUMBER(3,0)                   NOT NULL,
  DAT_VALID_FROM          DATE                          NOT NULL,
  UNIT_CURRENCY_EXCHANGE  NUMBER(6,2)                   NOT NULL,
  RATE_CURRENCY_EXCHANGE  NUMBER(18,4)                  NULL,
  DAT_DAYEND              DATE                          NOT NULL,
  LOAD_ID                 NUMBER(38)                    NOT NULL,
  DC_SERVER_ID            NUMBER(38)                    NOT NULL,
  BIC_ZMLILA              VARCHAR(20)                   NULL,
  EXTRACTION_TS           TIMESTAMP_NTZ(6)              NULL,
  RECORD_ID               NUMBER(10,0)                  NULL,
  SOURCE_SYSTEM           VARCHAR(20) COLLATE 'en-ci'   NULL
);