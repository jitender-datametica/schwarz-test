CREATE TRANSIENT TABLE P_LEW_LOAD.T_WAWI_INV_WH_L_0_2
(
  COUNTRY_ISO_CD          VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  WH_ID                   VARCHAR(3) COLLATE 'en-ci'    NOT NULL,
  INV_ID                  NUMBER(38)                    NOT NULL,
  INV_DESC                VARCHAR(25) COLLATE 'en-ci'   NULL,
  DAT_DAYEND              DATE                          NOT NULL,
  INV_TYPE                VARCHAR(1) COLLATE 'en-ci'    NULL,
  BUSYEAR                 NUMBER(38)                    NULL,
  DAT_FORMDATE            DATE                          NOT NULL,
  INV_EVAL_FG             NUMBER(38)                    NULL,
  STORE_PLACE             NUMBER(38)                    NULL,
  AISLE_DESC              VARCHAR(35) COLLATE 'en-ci'   NULL,
  SLOT_NR                 NUMBER(38)                    NOT NULL,
  ORIG_ITEM_NR            NUMBER(10,0)                  NOT NULL,
  CASE_SIZE               VARCHAR(4) COLLATE 'en-ci'    NOT NULL,
  QTY_CASE_INV_WH         NUMBER(18,4)                  NULL,
  QTY_PIECE_INV_WH        NUMBER(18,4)                  NULL,
  PRICE_RETAIL_INV_WH     NUMBER(18,4)                  NULL,
  QTY_EXPECTED_INV_WH     NUMBER(18,4)                  NULL,
  QTY_TOTAL_INV_WH        NUMBER(18,4)                  NULL,
  QTY_RAMP_INV_WH         NUMBER(18,4)                  NULL,
  DIFF_QTY_INV_WH         NUMBER(18,4)                  NULL,
  CASE_SIZE_DEC           NUMBER(9,4)                   NULL,
  PRICE_RETAIL_INV_WH_NET NUMBER(18,4)                  NULL,
  LOAD_ID                 NUMBER(38)                    NOT NULL,
  DC_SERVER_ID            NUMBER(38)                    NOT NULL
)
;
