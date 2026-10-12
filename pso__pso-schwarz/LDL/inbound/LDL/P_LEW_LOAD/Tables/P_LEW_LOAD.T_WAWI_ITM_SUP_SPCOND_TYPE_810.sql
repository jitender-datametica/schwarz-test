CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITM_SUP_SPCOND_TYPE_810
(
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  SPCOND_TYPE_ID    NUMBER(38)                    NOT NULL,
  DAT_REC_START     DATE                          NOT NULL,
  DAT_REC_END       DATE                          NOT NULL,
  SPCOND_SUBTYPE_ID NUMBER(38)                    NOT NULL,
  LANGUAGE_ID       NUMBER(38)                    NOT NULL,
  SPCOND_TYPE_DESC  VARCHAR(50) COLLATE 'en-ci'   NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL
);