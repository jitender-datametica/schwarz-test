CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_PCWO_REASON_DESC_HQ_999_1
(
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  PCWO_REASON_ID    NUMBER(38)                    NOT NULL,
  LANGUAGE_ID       NUMBER(38)                    NOT NULL,
  DAT_REC_START     DATE                          NOT NULL,
  DAT_REC_END       DATE                          NOT NULL,
  PCWO_REASON_DESC  VARCHAR(50) COLLATE 'en-ci'   NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL
);