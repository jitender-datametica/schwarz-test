CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_BNL_GRP_C_1
(
  ERR_ID                  NUMBER(18,0)                  NOT NULL  AUTOINCREMENT START 1 INCREMENT 1 ,
  ERR_RELEASE             NUMBER(38)                    NULL DEFAULT 0,
  RELEASE_USER            VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE                DATE                          NOT NULL DEFAULT CURRENT_DATE,
  ERR_CD                  NUMBER(38)                    NULL,
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
  LOAD_ID                 NUMBER(38)                    NULL
)
;