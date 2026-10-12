CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_BNL_GRP_L_0
(
  COUNTRY_ISO_CD          VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID                   VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  STATISTICGROUP_ID       NUMBER(38)                    NOT NULL,
  STATISTICGROUP_DESC     VARCHAR(35) COLLATE 'en-ci'   NOT NULL,
  STATISTICGROUP_POSITION NUMBER(38)                    NOT NULL,
  EDIT_FG                 NUMBER(38)                    NULL,
  STATISTICGROUP_DESC_NAT VARCHAR(35) COLLATE 'en-ci'   NOT NULL,
  MAINITEMGROUP_ID        NUMBER(38)                    NULL,
  DAT_VALID_FROM          DATE                          NOT NULL,
  DAT_VALID_UNTIL         DATE                          NOT NULL,
  DAT_DAYEND              DATE                          NULL,
  LOAD_ID                 NUMBER(38)                    NULL,
  DC_SERVER_ID            NUMBER(38)                    NOT NULL,
  BIC_ZMLILA              VARCHAR(20)                   NULL,
  EXTRACTION_DATE         DATE                          NULL,
  EXTRACTION_TS           TIMESTAMP_NTZ(6)              NULL,
  RECORD_ID               NUMBER(10,0)                  NULL,
  SOURCE_SYSTEM           VARCHAR(20) COLLATE 'en-ci'   NULL
);