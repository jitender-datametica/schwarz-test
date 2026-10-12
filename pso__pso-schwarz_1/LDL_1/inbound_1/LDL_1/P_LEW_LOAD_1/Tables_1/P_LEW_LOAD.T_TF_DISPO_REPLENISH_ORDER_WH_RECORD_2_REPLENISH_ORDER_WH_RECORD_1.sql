CREATE TRANSIENT TABLE P_LEW_LOAD.T_TF_DISPO_REPLENISH_ORDER_WH_RECORD_2_REPLENISH_ORDER_WH_RECORD_1
(
  CLIENT_ID                             NUMBER(38)                    NOT NULL,
  LIDL_COUNTRY                          VARCHAR(40)                   NOT NULL,
  DISPO_REPLENISH_ORDER_WH_RECORD_WHNR  VARCHAR(250)                  NOT NULL,
  DISPO_REPLENISH_ORDER_WH_RECORD_PO_NR NUMBER(38,0)                  NOT NULL,
  ORDER_RECORD_ID                       VARCHAR(20) COLLATE 'en-ci'   NOT NULL,
  ORDER_SEQ_NR                          NUMBER(38)                    NOT NULL,
  ORDER_CREATED_TMSP                    TIMESTAMP_NTZ(0)              NULL,
  ORDER_UPDATED_TMSP                    TIMESTAMP_NTZ(0)              NULL,
  ORDER_STATUS_CD                       NUMBER(38)                    NULL,
  ORDER_BATCH_ID                        NUMBER(38)                    NULL,
  ORIG_SUPPLIER_NR                      VARCHAR(40)                   NULL,
  DELIVERY_DT                           DATE                          NOT NULL,
  DWH_CAL_DT                            DATE                          NOT NULL,
  EXTRACTION_DT                         DATE                          NULL,
  DWH_MAPPING_DT                        DATE                          NOT NULL,
  TF_ERROR_FG                           NUMBER(1,0)                   NULL,
  RECORD_ID                             VARCHAR(300)                  NOT NULL,
  FILENAME                              VARCHAR(1000)                 NOT NULL
);