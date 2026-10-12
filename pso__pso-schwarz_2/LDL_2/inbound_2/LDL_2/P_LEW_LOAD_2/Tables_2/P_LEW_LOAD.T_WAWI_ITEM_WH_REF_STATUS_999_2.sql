CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITEM_WH_REF_STATUS_999_2
(
  CLIENT_ID         NUMBER(38)                    NOT NULL,
  ITEM_STATUS       NUMBER(38)                    NOT NULL,
  ITEM_STATUS_DESC  VARCHAR(50) COLLATE 'en-ci'   NOT NULL,
  LANGUAGE_ID       NUMBER(38)                    NOT NULL,
  LOAD_ID           NUMBER(38)                    NOT NULL
);