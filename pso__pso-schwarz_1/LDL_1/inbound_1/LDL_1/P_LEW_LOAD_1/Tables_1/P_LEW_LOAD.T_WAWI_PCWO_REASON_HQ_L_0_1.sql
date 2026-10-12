CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_PCWO_REASON_HQ_L_0_1
(
  COUNTRY_ISO_CD        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ              VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  PCWO_REASON_ID        NUMBER(38)                    NOT NULL,
  PCWO_REASON_ID_INT    NUMBER(38)                    NOT NULL,
  PCWO_GROUP_ID         NUMBER(38)                    NULL,
  PCWO_REASON_DESC_INT  VARCHAR(50) COLLATE 'en-ci'   NULL,
  PCWO_REASON_DESC_NAT  VARCHAR(50) COLLATE 'en-ci'   NOT NULL,
  PCWO_GROUP_DESC       VARCHAR(50) COLLATE 'en-ci'   NULL,
  PCWO_ACTIVE_FG        NUMBER(38)                    NOT NULL,
  PCWO_NEW_GROUP_CD     NUMBER(38)                    NULL,
  DAT_DAYEND            DATE                          NULL,
  LOAD_ID               NUMBER(38)                    NOT NULL,
  DC_SERVER_ID          NUMBER(38)                    NOT NULL,
  BIC_ZMLILA            VARCHAR(20)                   NULL,
  EXTRACTION_TS         TIMESTAMP_NTZ(6)              NULL,
  RECORD_ID             NUMBER(10,0)                  NULL,
  SOURCE_SYSTEM         VARCHAR(20) COLLATE 'en-ci'   NULL
);