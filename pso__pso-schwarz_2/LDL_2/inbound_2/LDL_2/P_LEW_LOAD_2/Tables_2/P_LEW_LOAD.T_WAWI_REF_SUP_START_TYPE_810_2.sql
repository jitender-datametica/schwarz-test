CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_REF_SUP_START_TYPE_810_2
(
  CLIENT_ID       NUMBER(38)                    NOT NULL,
  START_TYPE_CD   NUMBER(38)                    NOT NULL,
  DAT_REC_END     DATE                          NOT NULL,
  DAT_REC_START   DATE                          NOT NULL,
  START_TYPE_DESC VARCHAR(50) COLLATE 'en-ci'   NOT NULL,
  LANGUAGE_ID     NUMBER(38)                    NOT NULL,
  LOAD_ID         NUMBER(38)                    NOT NULL
);