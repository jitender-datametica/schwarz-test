CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_ITEMDELETE_HQ_L_0
(
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
  LOAD_ID             NUMBER(38)                    NULL,
  DC_SERVER_ID        NUMBER(38)                    NOT NULL,
  BIC_ZMLILA          VARCHAR(20)                   NULL,
  EXTRACTION_TS       TIMESTAMP_NTZ(6)              NULL,
  RECORD_ID           NUMBER(10,0)                  NULL,
  SOURCE_SYSTEM       VARCHAR(20) COLLATE 'en-ci'   NULL
);