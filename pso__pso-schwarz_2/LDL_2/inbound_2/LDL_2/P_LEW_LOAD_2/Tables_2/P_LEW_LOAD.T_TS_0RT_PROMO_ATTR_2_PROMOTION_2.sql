CREATE TRANSIENT TABLE P_LEW_LOAD.T_TS_0RT_PROMO_ATTR_2_PROMOTION_2
(
  RECORD_ID             NUMBER(10,0)                  NULL,
  CLIENT_ID             NUMBER(38)                    NULL,
  PROM_SID              NUMBER(38)                    NULL,
  SRC_AKTNR             VARCHAR(20)                   NULL,
  PROM_NAME             VARCHAR(100) COLLATE 'en-ci'  NULL,
  PROMOTION_CLASS_MARK  VARCHAR(20)                   NULL,
  PROMOTION_CLASS_LABEL VARCHAR(100) COLLATE 'en-ci'  NULL,
  PROMOTION_TYPE_MARK   VARCHAR(20)                   NULL,
  PROMOTION_TYPE_LABEL  VARCHAR(100) COLLATE 'en-ci'  NULL,
  DWH_LOAD_ID           NUMBER(38)                    NULL,
  DWH_CREATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_UPDATED           TIMESTAMP_NTZ(6)              NULL,
  DWH_MAPPING_DT        DATE                          NULL,
  ERROR_FG              NUMBER(38)                    NULL,
  ERROR_DESCR           VARCHAR(1000) COLLATE 'en-ci' NULL,
  FILENAME              VARCHAR(1000) COLLATE 'en-ci' NULL,
  HIST_ROW_NO           NUMBER(38)                    NULL
);