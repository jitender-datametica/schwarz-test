CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_PCWO_REASON_HQ_999
(
  CLIENT_ID           NUMBER(38)                    NOT NULL,
  PCWO_REASON_ID      NUMBER(38)                    NOT NULL,
  DAT_REC_START       DATE                          NOT NULL,
  DAT_REC_END         DATE                          NOT NULL,
  PCWO_REASON_ID_INT  NUMBER(38)                    NOT NULL,
  PCWO_GROUP_ID       NUMBER(38)                    NULL,
  PCWO_GROUP_DESC     VARCHAR(50) COLLATE 'en-ci'   NULL,
  PCWO_ACTIVE_FG      NUMBER(38)                    NOT NULL,
  PCWO_NEW_GROUP_CD   NUMBER(38)                    NULL,
  LOAD_ID             NUMBER(38)                    NOT NULL
);