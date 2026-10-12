CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_FUNC_PERSON_L_2
(
  CLIENT_ID             NUMBER(38)                    NOT NULL,
  COUNTRY_ISO_CD        VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_LOC_SID_EXP        NUMBER(38)                    NULL,
  WH_ID                 VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  ST_LOC_SID            NUMBER(38)                    NOT NULL,
  ORIG_STORE_NR         NUMBER(38)                    NOT NULL,
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
  DAT_DAYEND            DATE                          NULL,
  LOAD_ID               NUMBER(38)                    NOT NULL,
  LOAD_ID_UPTD          NUMBER(38)                    NULL
);