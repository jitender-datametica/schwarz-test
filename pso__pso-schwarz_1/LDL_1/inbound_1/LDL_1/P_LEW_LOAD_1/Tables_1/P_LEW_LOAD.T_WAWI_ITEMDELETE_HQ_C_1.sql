CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITEMDELETE_HQ_C_1
(
  ERR_ID              NUMBER(18,0)                  NOT NULL  AUTOINCREMENT START 1 INCREMENT 1 ,
  ERR_RELEASE         NUMBER(38)                    NULL DEFAULT 0,
  RELEASE_USER        VARCHAR(30) COLLATE 'en-ci'   NULL,
  ERR_DATE            DATE                          NOT NULL DEFAULT CURRENT_DATE,
  ERR_CD              NUMBER(38)                    NULL,
  COUNTRY_ISO_CD      VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID_HQ            VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  ITEM_NR_LONG        VARCHAR(24) COLLATE 'en-ci'   NULL,
  ORIG_ITEM_NR        NUMBER(10,0)                  NULL,
  CASE_SIZE           NUMBER(38)                    NULL,
  ITEM_DELETE_DESC    VARCHAR(35) COLLATE 'en-ci'   NULL,
  DAT_ITEM_DELETE     DATE                          NULL,
  STATUS_ITEM_DELETE  NUMBER(38)                    NULL,
  ITEM_CLOSED_FG      NUMBER(1,0)                   NULL,
  DAT_DAYEND          DATE                          NULL,
  LOAD_ID             NUMBER(38)                    NULL
)
;