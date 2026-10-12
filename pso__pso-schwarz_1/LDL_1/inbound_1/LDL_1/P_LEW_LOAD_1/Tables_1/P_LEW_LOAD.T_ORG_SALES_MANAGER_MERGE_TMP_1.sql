CREATE TRANSIENT TABLE P_LEW_LOAD.T_ORG_SALES_MANAGER_MERGE_TMP_1
(
  ASPECT_ID           NUMBER(38)                    NOT NULL,
  CLIENT_ID           NUMBER(38)                    NOT NULL,
  WH_LOC_SID          NUMBER(38)                    NOT NULL,
  WH_LOC_SID_EXP      NUMBER(38)                    NOT NULL,
  SALES_MANAGER_ID    NUMBER(38)                    NOT NULL,
  ACCOUNT_MANAGER_ID  NUMBER(38)                    NULL,
  SALES_MANAGER_NAME  VARCHAR(50) COLLATE 'en-ci'   NULL
);