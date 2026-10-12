CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITEMFAM_HQ_C_1
(
  ERR_ID                  NUMBER(18,0)                  NOT NULL  AUTOINCREMENT START 1 INCREMENT 1 ,
  ERR_RELEASE             NUMBER(38)                    NULL DEFAULT 0,
  RELEASE_USER            VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE                DATE                          NOT NULL DEFAULT CURRENT_DATE,
  ERR_CD                  NUMBER(38)                    NULL,
  COUNTRY_ISO_CD          VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ                VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  ITEM_FAMILYGROUP_ID     NUMBER(38)                    NOT NULL,
  SUBITEMGROUP_ID         NUMBER(38)                    NOT NULL,
  MAINITEMGROUP_ID        NUMBER(38)                    NOT NULL,
  FAMILY_CD               NUMBER(38)                    NOT NULL,
  ITEM_FAMILY_DESC        VARCHAR(120) COLLATE 'en-ci'  NOT NULL,
  ITEM_FAMILY_SHORT_DESC  VARCHAR(15) COLLATE 'en-ci'   NULL,
  DAT_DAYEND              DATE                          NULL,
  LOAD_ID                 NUMBER(38)                    NULL
)
;