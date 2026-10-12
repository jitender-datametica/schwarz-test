CREATE TRANSIENT TABLE P_LEW_LOAD.T_ORG_ACCOUNT_MANAGER_MRG_TMP
(
  ASPECT_ID             NUMBER(38)                    NOT NULL,
  CLIENT_ID             NUMBER(38)                    NOT NULL,
  WH_LOC_SID            NUMBER(38)                    NOT NULL,
  ACCOUNT_MANAGER_ID    NUMBER(38)                    NOT NULL,
  ACCOUNT_MANAGER_NAME  VARCHAR(50) COLLATE 'en-ci'   NULL
);