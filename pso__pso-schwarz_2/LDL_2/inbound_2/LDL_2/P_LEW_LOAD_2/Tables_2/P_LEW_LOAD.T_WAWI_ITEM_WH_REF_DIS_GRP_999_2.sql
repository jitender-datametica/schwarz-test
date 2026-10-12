CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITEM_WH_REF_DIS_GRP_999_2
(
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  DISPO_GROUP_ID    NUMBER(38)                    NOT NULL,
  DAT_REC_END       DATE                          NOT NULL,
  DAT_REC_START     DATE                          NOT NULL,
  DISPO_GROUP_DESC  VARCHAR(35) COLLATE 'en-ci'   NOT NULL,
  LANGUAGE_ID       NUMBER(38)                    NOT NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL
);