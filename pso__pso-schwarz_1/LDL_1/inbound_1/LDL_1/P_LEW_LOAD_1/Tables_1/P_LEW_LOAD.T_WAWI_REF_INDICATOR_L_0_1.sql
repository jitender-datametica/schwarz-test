CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_REF_INDICATOR_L_0_1
(
  INDICATOR_ID        NUMBER(38)                    NOT NULL,
  INDICATOR_DESC      VARCHAR(200) COLLATE 'en-ci'  NOT NULL,
  INDICATOR_VALUETYPE VARCHAR(15) COLLATE 'en-ci'   NULL,
  DAT_DAYEND          DATE                          NOT NULL,
  LOAD_ID             NUMBER(38)                    NOT NULL,
  BIC_ZMLILA          VARCHAR(20)                   NULL,
  EXTRACTION_TS       TIMESTAMP_NTZ(6)              NULL,
  EXTRACTION_DATE     DATE                          NULL,
  RECORD_ID           NUMBER(10,0)                  NULL,
  SOURCE_SYSTEM       VARCHAR(20) COLLATE 'en-ci'   NULL,
  TIMESTAMP_FN        TIMESTAMP_NTZ(0)              NOT NULL,
  DC_SERVER_ID        NUMBER(38)                    NOT NULL
);