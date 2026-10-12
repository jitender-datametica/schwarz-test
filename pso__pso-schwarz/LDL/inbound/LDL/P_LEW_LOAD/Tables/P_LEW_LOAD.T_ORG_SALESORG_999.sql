CREATE TRANSIENT TABLE P_LEW_LOAD.T_ORG_SALESORG_999
(
  CLIENT_ID             NUMBER(38)                    NOT NULL,
  ST_LOC_SID            NUMBER(38)                    NOT NULL,
  DAT_REC_START         DATE                          NOT NULL,
  DAT_REC_END           DATE                          NOT NULL,
  SALES_MANAGER_ID      NUMBER(38)                    NOT NULL,
  SALES_MANAGER_NAME    VARCHAR(50) COLLATE 'en-ci'   NULL,
  ACCOUNT_MANAGER_ID    NUMBER(38)                    NOT NULL,
  ACCOUNT_MANAGER_NAME  VARCHAR(50) COLLATE 'en-ci'   NULL,
  STORE_MANAGER_ID      NUMBER(38)                    NOT NULL,
  STORE_MANAGER_NAME    VARCHAR(50) COLLATE 'en-ci'   NULL,
  ORGANISATION_ID       NUMBER(38)                    NOT NULL,
  GENERAL_MANAGER_ID    VARCHAR(9) COLLATE 'en-ci'    NOT NULL,
  GENERAL_MANAGER_NAME  VARCHAR(32) COLLATE 'en-ci'   NULL,
  DISTRICT_ID           VARCHAR(200) COLLATE 'en-ci'  NOT NULL,
  DAT_VALID_FROM        DATE                          NOT NULL,
  DAT_VALID_UNTIL       DATE                          NULL,
  WH_LOC_SID_EXP        NUMBER(38)                    NOT NULL,
  LOAD_ID               NUMBER(38)                    NOT NULL
);