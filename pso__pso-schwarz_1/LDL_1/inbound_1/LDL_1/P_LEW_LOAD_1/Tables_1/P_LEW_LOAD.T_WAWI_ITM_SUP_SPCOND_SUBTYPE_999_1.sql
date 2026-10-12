CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITM_SUP_SPCOND_SUBTYPE_999_1
(
  CLIENT_ID           NUMBER(38)                    NOT NULL,
  SPCOND_SUBTYPE_ID   NUMBER(38)                    NOT NULL,
  DAT_REC_START       DATE                          NOT NULL,
  DAT_REC_END         DATE                          NOT NULL,
  SPCOND_SUBTYPE_DESC VARCHAR(150) COLLATE 'en-ci'  NULL,
  LANGUAGE_ID         NUMBER(38)                    NOT NULL,
  LOAD_ID             NUMBER(38)                    NOT NULL
);