CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_BNL_GRP_999
(
  CLIENT_ID               NUMBER(38)                    NOT NULL,
  STATISTICGROUP_ID       NUMBER(38)                    NOT NULL,
  DAT_REC_START           DATE                          NOT NULL,
  DAT_REC_END             DATE                          NOT NULL,
  DAT_VALID_FROM          DATE                          NULL,
  DAT_VALID_UNTIL         DATE                          NULL,
  STATISTICGROUP_DESC     VARCHAR(50) COLLATE 'en-ci'   NULL,
  EDIT_FG                 NUMBER(38)                    NULL,
  STATISTICGROUP_POSITION NUMBER(38)                    NULL,
  LANGUAGE_ID             NUMBER(38)                    NOT NULL,
  LOAD_ID                 NUMBER(38)                    NOT NULL
);