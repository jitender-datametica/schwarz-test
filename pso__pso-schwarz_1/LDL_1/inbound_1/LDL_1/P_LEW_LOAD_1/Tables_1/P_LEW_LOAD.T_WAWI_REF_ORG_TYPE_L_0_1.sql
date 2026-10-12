CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_REF_ORG_TYPE_L_0_1
(
  ORG_TYPE_ID     NUMBER(38)                    NOT NULL,
  ORG_TYPE_DESC   VARCHAR(100) COLLATE 'en-ci'  NOT NULL,
  DAT_DAYEND      DATE                          NOT NULL,
  LOAD_ID         NUMBER(38)                    NOT NULL,
  BIC_ZMLILA      VARCHAR(20)                   NULL,
  EXTRACTION_TS   TIMESTAMP_NTZ(6)              NULL,
  EXTRACTION_DATE DATE                          NULL,
  RECORD_ID       NUMBER(10,0)                  NULL,
  SOURCE_SYSTEM   VARCHAR(20) COLLATE 'en-ci'   NULL,
  TIMESTAMP_FN    TIMESTAMP_NTZ(0)              NOT NULL,
  DC_SERVER_ID    NUMBER(38)                    NOT NULL
);